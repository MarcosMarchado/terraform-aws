#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "vpc-ec2" {
    cidr_block = "10.0.0.0/17"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "VPC-ec2"
    }
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public-subnet-azA" {
  vpc_id     = aws_vpc.vpc-ec2.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public-subnet-azB" {
  vpc_id     = aws_vpc.vpc-ec2.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
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
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet-azA.id
  route_table_id = aws_route_table.rt-subnet-public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-subnet-azB.id
  route_table_id = aws_route_table.rt-subnet-public.id
}
#10.0.0.0/16 VPC
#10.0.0.0/20 SUBNET

#10.0.0.0/16	 -> O cidr na tabela de rotas precisa ser o da VPC para dizer que o acesso é local
