# aws certificate manager

resource "aws_acm_certificate" "certificate" {
  provider = aws.us-east-1

  domain_name = var.domain_name
  subject_alternative_names = [
    join(".", ["www", var.domain_name])
  ]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.bucket_tags
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]
}