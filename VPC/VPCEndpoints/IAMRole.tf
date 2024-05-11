resource "aws_iam_role" "Ec2Role" {
  name = "Ec2Role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "s3FullAcessEC2"
  description = "Policy granting full access to S3"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy_to_role" {
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
  role       = aws_iam_role.Ec2Role.name
}