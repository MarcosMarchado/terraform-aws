resource "aws_instance" "ec2-subnetB" {
  ami               = data.aws_ami.debian.id
  instance_type     = "t2.micro"
  key_name          = "ec2"
  availability_zone = "us-east-1b"
  subnet_id = aws_subnet.subnetB.id
  #associate_public_ip_address = true
  
  vpc_security_group_ids = [
    aws_vpc.vpc-ec2.default_security_group_id
  ]

  tags = {
    Name = "ec2-subnetB"
  }

}


# resource "aws_eip" "ip-fixo" {
#   instance = aws_instance.nginx-instance-terraform.id
#   domain   = "vpc"
# }

### sg é statefull, ou seja todo trafégo que entra é permitido voltar

##SG default permite todos os acesso pra quem está no mesmo grupo de segurança