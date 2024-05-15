resource "aws_s3_object" "cat1" {
  bucket = aws_s3_bucket.example.id
  key    = "cat.jpeg"
  source = "../src/cat.jpeg"
  content_type = "image/jpeg"

  etag = filemd5("../src/cat.jpeg")
}

resource "aws_s3_object" "cat2" {
  bucket = aws_s3_bucket.example.id
  key    = "cat2.jpeg"
  source = "../src/cat2.jpeg"
  content_type = "image/jpeg"

  etag = filemd5("../src/cat2.jpeg")
}
