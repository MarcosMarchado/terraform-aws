resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnetA.id
  route_table_id = aws_route_table.route-table.id
}