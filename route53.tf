#

resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = var.dvo_allow_overwrite
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.dvo_ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.dns_zone.zone_id

}

resource "aws_route53_record" "cloudfront_a_record" {
  for_each = aws_cloudfront_distribution.distribution.aliases

  zone_id = data.aws_route53_zone.dns_zone.zone_id

  name = each.value
  type = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}