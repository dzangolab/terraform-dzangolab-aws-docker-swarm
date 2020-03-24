resource "aws_security_group" "aws-swarm" {
  name   = "${var.swarm_name}-swarm-security-group"
  vpc_id = aws_vpc.main.id

  # http-outbound-sg
  egress {
    from_port = 2377
    to_port   = 2377
    protocol  = "tcp"
    self      = true
  }

  # for container network discovery
  egress {
    from_port = 7946
    to_port   = 7946
    protocol  = "tcp"
    self      = true
  }

  # UDP for the container overlay network
  egress {
    from_port = 4789
    to_port   = 4789
    protocol  = "udp"
    self      = true
  }

  # for container network discovery
  egress {
    from_port = 7946
    to_port   = 7946
    protocol  = "udp"
    self      = true
  }

  # ntp-outbound-sg
  ingress {
    from_port = 2377
    to_port   = 2377
    protocol  = "tcp"
    self      = true
  }

  # for container network discovery
  ingress {
    from_port = 7946
    to_port   = 7946
    protocol  = "tcp"
    self      = true
  }

  # UDP for the container overlay network.
  ingress {
    from_port = 4789
    to_port   = 4789
    protocol  = "udp"
    self      = true
  }

  # for container network discovery.
  ingress {
    from_port = 7946
    to_port   = 7946
    protocol  = "udp"
    self      = true
  }
}

