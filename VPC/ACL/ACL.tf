## Com esse ACL só vou conseguir me conectar a instancia da subnet B através da instancia da subnet A
resource "aws_network_acl" "ACL-vpc-ec2" {
  vpc_id = aws_vpc.vpc-ec2.id


  egress {
    protocol   = -1
    rule_no    = 1
    action     = "allow"
    cidr_block = aws_subnet.public-subnet-azA.cidr_block
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 1
    action     = "allow"
    cidr_block = aws_subnet.public-subnet-azA.cidr_block
    from_port  = 0
    to_port    = 0
  }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 2
#     action     = "allow"
#     cidr_block = aws_subnet.public-subnet-azA.cidr_block
#     from_port  = 80
#     to_port    = 80
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 2
#     action     = "allow"
#     cidr_block = aws_subnet.public-subnet-azA.cidr_block
#     from_port  = 80
#     to_port    = 80
#   }

  tags = {
    Name = "ACL instancia EC2"
  }

}


# resource "aws_network_acl_rule" "acl-regra-entrada-ssh" {
#   network_acl_id = aws_network_acl.ACL-vpc-ec2.id
#   rule_number    = 1
#   egress         = false
#   protocol       = "tcp"
#   rule_action    = "allow"
#   cidr_block     = aws_subnet.public-subnet-azA.cidr_block
#   from_port      = 22
#   to_port        = 22
# }

# resource "aws_network_acl_rule" "acl-regra-saida-ssh" {
#   network_acl_id = aws_network_acl.ACL-vpc-ec2.id
#   rule_number    = 1
#   egress         = true
#   protocol       = "tcp"
#   rule_action    = "allow"
#   cidr_block     = aws_subnet.public-subnet-azA.cidr_block
#   from_port      = 22
#   to_port        = 22
# }

resource "aws_network_acl_association" "main" {
  network_acl_id = aws_network_acl.ACL-vpc-ec2.id
  subnet_id      = aws_subnet.public-subnet-azB.id
}
