terraform {
  backend "s3" {
    bucket  = "concept-terraform-state"
    key     = "personal-blog/website.tfstate"
    region  = "eu-west-1"
    encrypt = true
    profile = "personal-blog"
  }
  required_version = "~> 0.12.4"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
