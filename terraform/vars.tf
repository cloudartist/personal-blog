variable "aws_region" {
  default     = "eu-west-1"
  description = "AWS region"
}
variable "aws_profile" {
  default     = "personal-blog"
  description = "AWS profile with credentials to your AWS account"
}
variable "domain_name" {
  default     = "perception.ninja"
  description = "Project domain name for DNS management"
}

variable "index_document" {
  type        = string
  description = "HTML to show at root"
  default     = "index.html"
}

variable "error_document" {
  type        = string
  description = "HTML to show in case of error"
  default     = "error.html"
}
