resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-ec2.id

  tags = {
    Name = "InternetGateway ec2"
  }
}