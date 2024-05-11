resource "aws_s3_bucket" "S3-Bucket" {
  bucket = "dorinha-ec2"

  tags = {
    Name        = "dora"
  }
}