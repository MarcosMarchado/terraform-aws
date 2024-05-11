resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc-endpoint.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    cidr_block = aws_vpc.vpc-endpoint.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "RouteTable"
  }
}