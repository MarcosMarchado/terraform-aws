resource "aws_security_group" "ec2-load-balancer-sg" {
  name        = "loadbalancer-sg"
  description = "Permite a conexao SSH e WEB"
  vpc_id      = "vpc-095ef5fef694db460"

  tags = {
    Name = "Permite conexao de entrada para o LB"
  }
}

## Security group rules
resource "aws_vpc_security_group_ingress_rule" "SSH-ingress-rule-loadbalancer" {
  security_group_id = aws_security_group.ec2-load-balancer-sg.id
  cidr_ipv4         = "45.190.121.31/32"
  from_port         = 22
  ip_protocol       = "TCP"
  to_port           = 22
  description       = "Conexao SSH entrada"
}

## HTTP e HTTPS
resource "aws_vpc_security_group_ingress_rule" "WEB-ingress-rule-loadbalancer" {
  security_group_id = aws_security_group.ec2-load-balancer-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "TCP"
  to_port           = 80
  description       = "Conexao WEB entrada"
}

resource "aws_vpc_security_group_egress_rule" "egress-rule-loadbalancer" {
  security_group_id = aws_security_group.ec2-load-balancer-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "TCP"
  to_port           = 80
  #ip_protocol       = "-1"
  description       = "Regras de saida HTTP"
}

