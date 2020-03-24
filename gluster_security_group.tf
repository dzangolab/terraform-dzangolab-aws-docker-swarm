resource "aws_security_group" "aws-gluster" {
  count  = var.enable_gluster ? 1 : 0
  name   = "${var.swarm_name}-gluster-security-group"
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 24007
    to_port   = 24008
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port = 24007
    to_port   = 24008
    protocol  = "udp"
    self      = true
  }

  egress {
    from_port = 49152
    to_port   = 49156
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 24007
    to_port   = 24008
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 24007
    to_port   = 24008
    protocol  = "udp"
    self      = true
  }

  ingress {
    from_port = 49152
    to_port   = 49156
    protocol  = "tcp"
    self      = true
  }
}
