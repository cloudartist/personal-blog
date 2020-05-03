resource "aws_iam_user" "deploy_user" {
  name = "DeployUser"
  path = "/"

  tags = {
    Name    = "DeployUser"
    Creator = "Terraform"
  }
}

# Use aws_iam_access_key if you want to automate secrets creation. Consider all security risks first!!! (for example - encrypted private statefile where secrets are in plain text)

# resource "aws_iam_access_key" "deploy_user_key" {
#   user = "${aws_iam_user.deploy_user.name}"
# }

resource "aws_iam_user_policy" "deploy_user_s3" {
  name = "S3BlogDeploy"
  user = aws_iam_user.deploy_user.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.blog.id}/*"
        }
    ]
}
EOF
}