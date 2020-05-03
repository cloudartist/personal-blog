data "aws_route53_zone" "my_zone" {
  name = "${var.domain_name}."
}

resource "aws_route53_record" "my_cert_validation" {
  name    = aws_acm_certificate.my_cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.my_cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.my_zone.zone_id
  records = [aws_acm_certificate.my_cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_route53_record" "website_dns" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.my_zone.zone_id

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}