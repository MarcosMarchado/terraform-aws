#Target group → Aplication load balancer -> Configurar o listener dentro do LB para apontar para o Target Group → criar modelo de execução → auto scaling group
data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["aws-marketplace"] # Canonical
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
resource "aws_launch_template" "ec2-launch-template" {
  name = "ec2-launch-template"
  image_id = data.aws_ami.debian.id
  instance_type = "t2.micro"
  key_name = "ec2"
  vpc_security_group_ids = [aws_security_group.launch-template-sg.id]
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "ec2-autoscaling-group" {
  name                      = "ec2-autoscaling-group"
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  #load_balancers            = [aws_lb.ec2-application-load-balancer.name]
  availability_zones        = ["us-east-1a", "us-east-1c"]


  launch_template {
    id      = aws_launch_template.ec2-launch-template.id
    version = "$Latest"
  }

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "ec2_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.ec2-autoscaling-group.id
  lb_target_group_arn    = aws_lb_target_group.ec2-target-group.arn
}