# resource "aws_iam_policy" "keyspaces_read_policy" {
#   name        = "keyspaces_read_policy"
#   description = "Policy keyspaces"
  
#   policy      = <<EOF
#     {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#         "Effect": "Allow",
#         "Action": [
#             "cassandra:Select",
#             "cassandra:GetKeyspace"
#         ],
#         "Resource": "*"
#         }
#     ]
#     }
#     EOF
# }

# resource "aws_iam_user" "keyspace_quarkus" {
#   name = "keyspace_quarkus"
# }

# resource "aws_iam_user_policy_attachment" "attach_policy" {
#   user       = aws_iam_user.keyspace_quarkus.name
#   policy_arn = aws_iam_policy.keyspaces_read_policy.arn
# }

# resource "aws_iam_access_key" "example_user_access_key" {
#   user = aws_iam_user.keyspace_quarkus.name
# }

# resource "aws_iam_service_specific_credential" "keyscredential" {
#   service_name = "cassandra.amazonaws.com"
#   user_name    = aws_iam_user.keyspace_quarkus.name
# }

# resource "local_file" "access_keys" {
#   content  = <<EOF
#     Access Key ID: ${aws_iam_access_key.example_user_access_key.id}
#     Secret Access Key: ${aws_iam_access_key.example_user_access_key.secret}
#     EOF
#   filename = "access_keys.txt"
# }

# resource "local_file" "access_keyspaces" {
#   content  = format("Service Password: %s\nService User Name: %s-at-477130638764",
#     aws_iam_service_specific_credential.keyscredential.service_password,
#     aws_iam_service_specific_credential.keyscredential.user_name
#   )
#   filename = "access_keyspaces.txt"
# }

# # Output para exibir a Access Key e Secret Key na saída
# # output "access_key_id" {
# #   value = aws_iam_access_key.example_user_access_key.id
# #   #sensitive = false
# # }

# # output "secret_access_key" {
# #   value = aws_iam_access_key.example_user_access_key.secret
# #   #sensitive = false
# # }