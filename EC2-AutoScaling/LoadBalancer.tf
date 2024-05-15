#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "ec2-application-load-balancer" {
  name               = "ec2-application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2-load-balancer-sg.id]
  subnets            = ["subnet-06ae30b82c6266446", "subnet-0337377ec6bfcc9ea"]

  tags = {
    Environment = "Criado com Terraform"
  }
}