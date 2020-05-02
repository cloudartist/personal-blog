# resource "aws_cloudfront_distribution" "main" {
#   is_ipv6_enabled = true

#   http_version = "http2"

#   origin {
#     origin_id   = aws_s3_bucket.blog.id
#     domain_name = aws_s3_bucket.blog.website_endpoint

#     # https://docs.aws.amazon.com/AmazonCloudFront/latest/
#     # DeveloperGuide/distribution-web-values-specify.html
#     custom_origin_config {
#       origin_protocol_policy = "http-only"

#       http_port  = "80"
#       https_port = "443"
#       origin_ssl_protocols = ["TLSv1.2"]
#     }

#     # s3_origin_config is not compatible with S3 website hosting, if this
#     # is used, /news/index.html will not resolve as /news/.
#     # https://www.reddit.com/r/aws/comments/6o8f89/can_you_force_cloudfront_only_access_while_using/
#     # s3_origin_config {
#     #   origin_access_identity = "${aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path}"
#     # }
#     # Instead, we use a secret to authenticate CF requests to S3 policy.
#     # Not the best, but...
#     custom_header {
#       name  = "User-Agent"
#       value = aws_ssm_parameter.cf_secret.value
#     }
#   }

#   enabled             = true
#   default_root_object = var.index_document

#   custom_error_response {
#     error_code            = "500"
#     error_caching_min_ttl = "300"
#     response_code         = "500"
#     response_page_path    = var.error_document
#   }

# #   aliases = concat([var.fqdn], var.aliases)

# #   price_class = var.cloudfront_price_class

#   default_cache_behavior {
#     target_origin_id = aws_s3_bucket.blog.id
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     compress         = true

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#      }

#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 300
#     max_ttl                = 1200
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#     acm_certificate_arn      = data.aws_acm_certificate.cf_ssl.arn
#     ssl_support_method       = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2018"
#   }

# #   web_acl_id = var.web_acl_id


# }


# data "aws_acm_certificate" "cf_ssl" {
#   domain      = "perception.ninja"
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }