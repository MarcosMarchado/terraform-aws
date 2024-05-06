#https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html
data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["aws-marketplace"] # Canonical
}


resource "aws_security_group" "instancia-sg" {
  name        = "Instancia SG"
  description = "Permite a conexao SSH e WEB"
  vpc_id      = "vpc-095ef5fef694db460"

  tags = {
    Name = "Permite conexao SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "conexao-ssh-ingress" {
  security_group_id = aws_security_group.instancia-sg.id
  cidr_ipv4         = "45.190.121.31/32"
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


resource "aws_instance" "nginx-instance-terraform" {
  ami               = data.aws_ami.debian.id
  instance_type     = "t2.micro"
  key_name          = "ec2"
  availability_zone = "us-east-1a"

  vpc_security_group_ids = [
    aws_security_group.instancia-sg.id
  ]

  tags = {
    Name = "By Terraform"
  }

}


resource "aws_eip" "ip-fixo" {
  instance = aws_instance.nginx-instance-terraform.id
  domain   = "vpc"
}

### sg é statefull, ou seja todo trafégo que entra é permitido voltar

##SG default permite todos os acesso pra quem está no mesmo grupo de segurança