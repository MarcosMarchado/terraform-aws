output "cluster_name" {
  value = aws_ecs_cluster.fargate_cluster.name
}

output "service_name" {
  value = aws_ecs_service.app.name
}