#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "ec2-target-group" {
  name     = "ec2-target-group"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = "vpc-095ef5fef694db460"
  #vpc_id   = aws_vpc.main.id
}