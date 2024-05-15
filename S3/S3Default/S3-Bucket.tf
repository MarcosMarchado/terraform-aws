resource "aws_s3_bucket" "example" {
  bucket = "dorinha-bucket-s3"

  tags = {
    Name  = "My bucket"
  }
}