resource "aws_cloudfront_distribution" "main" {
  is_ipv6_enabled = true

  http_version = "http2"

  origin {
    origin_id   = "S3-${aws_s3_bucket.blog.id}"
    domain_name = aws_s3_bucket.blog.bucket_domain_name

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.origin_access_identity.id}"
    }
  }

  enabled             = true
  default_root_object = var.index_document

  custom_error_response {
    error_code            = "500"
    error_caching_min_ttl = "300"
    response_code         = "500"
    response_page_path    = "/${var.error_document}"
  }

  aliases = [var.domain_name]

  price_class = "PriceClass_100" # US, Canada, Europe

  default_cache_behavior {
    target_origin_id = "S3-${aws_s3_bucket.blog.id}"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 1200
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = [
        "FR",
        "GB",
        "PL",
        "SE",
      ]
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.my_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "access-identity-blog"
}