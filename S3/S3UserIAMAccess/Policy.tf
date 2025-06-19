#https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html
resource "aws_s3_bucket_policy" "permission_public_anonymous_user" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.permission_public_anonymous_user.json
}

data "aws_iam_policy_document" "permission_public_anonymous_user" {
  statement {
    sid = "PublicRead"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = [ "*" ]
    }

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = [
      "${aws_s3_bucket.example.arn}/*",
    ]
  }
}