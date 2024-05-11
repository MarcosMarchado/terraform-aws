resource "aws_vpc" "vpc-ec2" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-ec2"
  }
}


resource "aws_subnet" "subnetA" {
  vpc_id     = aws_vpc.vpc-ec2.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/17"

  tags = {
    Name = "subnetA"
  }
}

resource "aws_subnet" "subnetB" {
  vpc_id     = aws_vpc.vpc-ec2.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.128.0/17"

  tags = {
    Name = "subnetB"
  }
}

resource "aws_route_table" "rt-subnet-public" {
  vpc_id = aws_vpc.vpc-ec2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    cidr_block        = aws_vpc.vpc-ec2.cidr_block
    gateway_id        = "local"
  }

  tags = {
    Name = "Tabela Rotas"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnetA.id
  route_table_id = aws_route_table.rt-subnet-public.id
}