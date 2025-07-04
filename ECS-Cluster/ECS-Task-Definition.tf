resource "aws_ecs_task_definition" "app" {
  family                   = "my-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "nginx",
    image     = "nginx:latest",
    cpu       = 256,
    memory    = 512,
    essential = true,
    portMappings = [
      {
        containerPort = 80,
        hostPort      = 80
      }
    ]
  }])
}