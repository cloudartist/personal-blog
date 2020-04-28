# If you store your code source in secure private repository consider chaining parameters to GitHub Actions to futher automate - https://www.terraform.io/docs/providers/github/index.html

# resource "github_actions_secret" "aws_key" {
#   repository       = "example_repository"
#   secret_name      = "AWS_ACCESS_KEY"
#   plaintext_value  = aws_iam_access_key.deploy_user_key.id
# }