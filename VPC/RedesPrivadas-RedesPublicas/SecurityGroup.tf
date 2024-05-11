resource "aws_security_group" "instancia-sg" {
  name        = "Instancia SG"
  description = "Permite a conexao SSH e WEB"
  vpc_id      = aws_vpc.vpc-ec2.id

  tags = {
    Name = "Permite conexao SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "conexao-ssh-ingress" {
  security_group_id = aws_security_group.instancia-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "TCP"
  to_port           = 22
  description       = "Conexao SSH entrada"
}

# resource "aws_vpc_security_group_egress_rule" "conexao-ssh-egress" {
#   security_group_id = aws_security_group.instancia-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
#   description       = "Conexao SSH saida"
# }


## HTTP e HTTPS
resource "aws_vpc_security_group_ingress_rule" "conexao-web-ingress-ipv4-http" {
  security_group_id = aws_security_group.instancia-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "TCP"
  to_port           = 80
  description       = "Conexao WEB entrada"
}

# resource "aws_vpc_security_group_egress_rule" "conexao-web-egress-ipv4-http" {
#   security_group_id = aws_security_group.instancia-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
#   description       = "Conexao WEB saida"
# }
