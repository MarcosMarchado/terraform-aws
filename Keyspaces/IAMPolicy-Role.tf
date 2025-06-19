resource "aws_iam_policy" "keyspaces_read_policy" {
  name        = "keyspaces_read_policy"
  description = "Policy for read access to Amazon Keyspaces"
  
  policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "cassandra:Select",
            "cassandra:GetKeyspace"
          ],
          "Resource": "*"
        }
      ]
    }
    EOF
}

resource "aws_iam_user" "keyspace_quarkus" {
  name = "keyspace_quarkus_user"
}

resource "aws_iam_role" "keyspaces_read_role" {
  name = "keyspaces_read_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "sts:AssumeRole",
      Effect   = "Allow",
      Principal = {
        AWS = aws_iam_user.keyspace_quarkus.arn
      }
    }]
  })
}

# resource "aws_iam_role" "keyspaces_read_role" {
#   name = "keyspaces_read_role"

#   assume_role_policy = <<EOF
#     {
#       "Version": "2012-10-17",
#       "Statement": [
#         {
#           "Effect": "Allow",
#           "Principal": {
#             "AWS": 
#           },
#           "Action": "sts:AssumeRole"
#         }
#       ]
#     }
#     EOF
# }




resource "aws_iam_user_policy_attachment" "attach_policy_user" {
  user       = aws_iam_user.keyspace_quarkus.name
  policy_arn = aws_iam_policy.keyspaces_read_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_read_policy" {
  role       = aws_iam_role.keyspaces_read_role.name
  policy_arn = aws_iam_policy.keyspaces_read_policy.arn
}

resource "aws_iam_access_key" "user_keyspaces_access_key" {
  user = aws_iam_user.keyspace_quarkus.name
}
## Output
resource "local_file" "access_keys" {
  content  = <<EOF
    Access Key ID: ${aws_iam_access_key.user_keyspaces_access_key.id}
    Secret Access Key: ${aws_iam_access_key.user_keyspaces_access_key.secret}
    EOF
  filename = "access_keys.txt"
}