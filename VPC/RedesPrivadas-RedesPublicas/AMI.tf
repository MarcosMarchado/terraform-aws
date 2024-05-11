#https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html
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