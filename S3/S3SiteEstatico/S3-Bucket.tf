resource "aws_s3_bucket" "site-bucket" {
  bucket = "site.dorinhashelby.com"
}

# resource "aws_s3_bucket_acl" "site-bucket_acl" {
#   bucket = aws_s3_bucket.site-bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket_website_configuration" "site-bucket-website-config" {
  bucket = aws_s3_bucket.site-bucket.id

  index_document {
    suffix = "index.html"
  }

}