resource "aws_subnet" "subnetA" {
  vpc_id     = aws_vpc.vpc-endpoint.id
  cidr_block = "10.0.0.0/17"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnetA"
  }
}

resource "aws_subnet" "subnetB" {
  vpc_id     = aws_vpc.vpc-endpoint.id
  cidr_block = "10.0.128.0/17"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnetB"
  }
}