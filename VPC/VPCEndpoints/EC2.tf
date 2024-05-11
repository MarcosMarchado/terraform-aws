resource "aws_instance" "EC2-instance" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnetA.id
  tenancy = "default"
  key_name = "ec2"
  associate_public_ip_address = true
  security_groups = [ 
    aws_vpc.vpc-endpoint.default_security_group_id, 
    aws_security_group.conexao-ssh.id 
  ]
  iam_instance_profile = aws_iam_instance_profile.EC2-Profile.name
  tags = {
    Name = "EC2-Instance"
  }
}

resource "aws_iam_instance_profile" "EC2-Profile" {
  name = "profile-role-ec2"
  role = aws_iam_role.Ec2Role.name
}