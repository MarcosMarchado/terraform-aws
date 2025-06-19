resource "aws_s3_object" "html" {
  bucket = aws_s3_bucket.site-bucket.id
  key    = "index.html"
  source = "../src/site/index.html"
  content_type = "text/html"
  etag = filemd5("../src/site/index.html")
}

resource "aws_s3_object" "video" {
  bucket = aws_s3_bucket.site-bucket.id
  key    = "video.mp4"
  source = "../src/site/video.mp4"
  content_type = "video/mp4"
  etag = filemd5("../src/site/video.mp4")
}
