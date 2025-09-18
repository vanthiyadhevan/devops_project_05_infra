resource "aws_security_group" "jenkins_sg" {
  vpc_id      = var.vpc_id
  description = "this jenkins server SG"
  name        = var.jenkins_name

  tags = {
    Name = var.jenkins_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_https" {
  security_group_id = aws_security_group.jenkins_sg.id
  ip_protocol       = var.protocol
  from_port         = var.https
  to_port           = var.https
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6_https" {
  security_group_id = aws_security_group.jenkins_sg.id
  ip_protocol       = var.protocol
  from_port         = var.https
  to_port           = var.https
  cidr_ipv6         = var.cidr_ipv6
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_http" {
  security_group_id = aws_security_group.jenkins_sg.id
  ip_protocol       = var.protocol
  from_port         = var.jenkins_port
  to_port           = var.jenkins_port
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_for_jenkins" {
  security_group_id = aws_security_group.jenkins_sg.id
  ip_protocol       = var.protocol
  from_port         = var.ssh
  to_port           = var.ssh
  cidr_ipv4         = var.all_inter_bound
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.jenkins_sg.id
  ip_protocol       = var.egress_protocol
  cidr_ipv4         = var.all_inter_bound
}


resource "aws_security_group" "docker_sg" {
  vpc_id      = var.vpc_id
  description = "this is the docker SG"
  name        = var.docker_name

  tags = {
    Name = var.docker_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_tls_access_http" {
  security_group_id = aws_security_group.docker_sg.id
  ip_protocol       = var.protocol
  from_port         = var.http
  to_port           = var.http
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_vpc_security_group_ingress_rule" "allow_jenkins_ssh" {
  security_group_id            = aws_security_group.docker_sg.id
  ip_protocol                  = var.protocol
  from_port                    = var.ssh
  to_port                      = var.ssh
  referenced_security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_for_docker" {
  security_group_id = aws_security_group.docker_sg.id
  ip_protocol       = var.protocol
  from_port         = var.ssh
  to_port           = var.ssh
  cidr_ipv4         = var.all_inter_bound
}