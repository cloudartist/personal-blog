provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "aws" {
  alias   = "acm_provider"
  profile = var.aws_profile
  region  = "us-east-1"
}
