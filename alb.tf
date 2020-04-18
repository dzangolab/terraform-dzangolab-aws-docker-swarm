resource "aws_lb" "web" {
  name               = "${var.swarm_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = aws_subnet.main.*.id

  tags = {
    Environment = var.env
  }
}

resource "aws_security_group" "lb" {
  name   = "${var.swarm_name}-lb-security-group"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb_target_group" "web" {
  name        = "${var.swarm_name}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    interval            = "30"
    path                = "/ping"
    port                = 80
    protocol            = "HTTP"
    timeout             = "5"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Environment = var.env
  }
}

resource "aws_lb_target_group_attachment" "web" {
  count            = var.swarm_manager_count
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = element(aws_instance.manager.*.id, count.index)
  port             = 80
}

resource "aws_lb_listener" "web_https" {
  load_balancer_arn = aws_lb.web.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_listener" "web_http" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_globalaccelerator_accelerator" "web" {
  count           = var.enable_accelerator ? 1 : 0
  name            = "${var.swarm_name}-accelerator"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "web" {
  count           = var.enable_accelerator ? 1 : 0
  accelerator_arn = aws_globalaccelerator_accelerator.web[0].id
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }

  port_range {
    from_port = 443
    to_port   = 443
  }
}

resource "aws_globalaccelerator_endpoint_group" "web" {
  count        = var.enable_accelerator ? 1 : 0
  listener_arn = aws_globalaccelerator_listener.web[0].id

  endpoint_configuration {
    endpoint_id = aws_lb.web.arn
    weight      = 100
  }
}
