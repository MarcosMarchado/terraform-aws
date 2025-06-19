resource "aws_ecs_cluster" "fargate_cluster" {
  name = "my-fargate-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Environment = "Production"
  }
}