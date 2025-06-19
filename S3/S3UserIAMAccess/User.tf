resource "aws_iam_user" "S3ReadOnlyUser" {
  name          = "S3ReadOnlyUser"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "example" {
  user    = aws_iam_user.S3ReadOnlyUser.name
}

resource "aws_iam_group_membership" "S3ReadOnlyMembership" {
  name = "S3ReadOnlyMembership"

  users = [
    aws_iam_user.S3ReadOnlyUser.name
  ]

  group = aws_iam_group.developers.name
}

output "password" {
  value = aws_iam_user_login_profile.example.encrypted_password
}

output "password2" {
  value = aws_iam_user_login_profile.example.password
}