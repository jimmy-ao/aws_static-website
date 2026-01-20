# outputs

output "cloudfront_aliases" {
  value = aws_cloudfront_distribution.distribution.aliases
}