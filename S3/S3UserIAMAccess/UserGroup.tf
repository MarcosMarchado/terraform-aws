#https://docs.aws.amazon.com/cli/latest/
#https://aws.amazon.com/pt/s3/storage-classes/#:~:text=As%20classes%20de%20armazenamento%20S3,Access%20(S3%20Standard%2DIA)
resource "aws_iam_group" "developers" {
  name = "S3-ReadOnly"
}

resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "S3-ReadOnly_policy"
  group = aws_iam_group.developers.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Get*",
          "s3:List*",
          "s3:Describe*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}