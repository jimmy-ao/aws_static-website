# actions

action "aws_cloudfront_create_invalidation" "resume" {
  config {
    distribution_id  = aws_cloudfront_distribution.distribution.id
    paths            = ["/*"]
    caller_reference = timestamp()
  }
}
