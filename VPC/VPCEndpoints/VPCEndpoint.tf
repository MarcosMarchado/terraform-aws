resource "aws_vpc_endpoint" "s3-endpoint" {
  vpc_id            = aws_vpc.vpc-endpoint.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.route-table.id]
}