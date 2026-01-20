# cloudfront

resource "aws_cloudfront_origin_access_control" "oac" {
  name = join("-", [var.bucket, "oac"])

  origin_access_control_origin_type = var.oac_origin_type
  signing_behavior                  = var.oac_signing_behavior
  signing_protocol                  = var.oac_signing_protocol
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id                = join("", [trim(var.bucket, "-"), random_id.ids.hex])
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  aliases = var.distribution_aliases

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.index_document_suffix

  default_cache_behavior {
    allowed_methods  = var.distribution_cache_allowed_methods
    cached_methods   = var.distribution_cache_cached_methods
    target_origin_id = join("", [trim(var.bucket, "-"), random_id.ids.hex])

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.distribution_cache_viewer_protocol_policy
    min_ttl                = var.distribution_cache_min_ttl
    default_ttl            = var.distribution_cache_default_ttl
    max_ttl                = var.distribution_cache_max_ttl
    compress               = var.distribution_cache_compress
  }

  restrictions {
    geo_restriction {
      restriction_type = var.distribution_geo_restriction_type
      locations        = var.distribution_geo_restriction_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certificate.arn
    minimum_protocol_version = var.distribution_minimum_protocol_version
    ssl_support_method       = var.distribution_ssl_support_method
  }
}