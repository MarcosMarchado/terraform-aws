resource "aws_instance" "ec2-subnetA" {
  ami               = data.aws_ami.debian.id
  instance_type     = "t2.micro"
  key_name          = "ec2"
  availability_zone = "us-east-1a"
  subnet_id = aws_subnet.subnetA.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.instancia-sg.id,
    aws_vpc.vpc-ec2.default_security_group_id
  ]

  tags = {
    Name = "ec2-subnetA"
  }

}


# resource "aws_eip" "ip-fixo" {
#   instance = aws_instance.nginx-instance-terraform.id
#   domain   = "vpc"
# }

### sg é statefull, ou seja todo trafégo que entra é permitido voltar

##SG default permite todos os acesso pra quem está no mesmo grupo de segurança