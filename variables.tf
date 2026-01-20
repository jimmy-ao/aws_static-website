#  variables

variable "profile" {
  type        = string
  description = "Profile used to create Terraform resources."
}

variable "domain_name" {
  type        = string
  description = "Domain full qualified name."
}

variable "region" {
  type        = string
  description = "Region used to deploy resources in."
  default     = "eu-north-1"
}

variable "bucket" {
  type        = string
  description = "Set bucket name."
}

variable "bucket_tags" {
  type        = map(string)
  description = "Set bucket tags."
}

variable "versioning_status" {
  type        = string
  description = "Define if versioning is enabled on the bucket or not."
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled", "Suspended"], var.versioning_status)
    error_message = "Versioning status does not match correct value."
  }
}

variable "index_document_suffix" {
  type        = string
  description = "Define the index document suffix for website configuration."
  default     = "index.html"
}

variable "error_document_key" {
  type        = string
  description = "Define the error document key for website configuration."
  default     = "error.html"
}

variable "bucket_block_public_acls" {
  type        = bool
  description = "Define if public ACLs are blocked on the bucket or not."
  default     = true
}

variable "bucket_block_public_policy" {
  type        = bool
  description = "Define if public policy is blocked on the bucket or not."
  default     = true
}

variable "bucket_ignore_public_acls" {
  type        = bool
  description = "Define if public ACLs are ignored on the bucket or not."
  default     = true
}

variable "bucket_restrict_public_buckets" {
  type        = bool
  description = "Define if public buckets are restricted on the bucket or not."
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = "Define if force destroy is enbale on the bucket or not."
  default     = false
}

variable "accelerate_configuration_status" {
  type        = bool
  description = "Define if Amazon S3 Transfer Acceleration is enabled on the bucket or not."
  default     = false
}

#
### cloudfront

# variable "oac_name" {
#   type        = string
#   description = "CloudFront oac name."
# }

variable "oac_origin_type" {
  type        = string
  description = "CloudFront oac origin type."
  default     = "s3"

  validation {
    condition     = contains(["lambda", "mediapackagev2", "mediastore", "s3"], var.oac_origin_type)
    error_message = "Origin type does not match correct value."
  }
}

variable "oac_signing_behavior" {
  type        = string
  description = "CloudFront oac signing behavior."
  default     = "always"

  validation {
    condition     = contains(["always", "never", "no-override"], var.oac_signing_behavior)
    error_message = "Signing behavior does not match correct value."
  }
}

variable "oac_signing_protocol" {
  type        = string
  description = "CloudFront oac signin protocol."
  default     = "sigv4"

  validation {
    condition     = var.oac_signing_protocol == "sigv4"
    error_message = "Signing protocol does not match the correct value."
  }
}

variable "distribution_aliases" {
  type        = list(string)
  description = "CloudFront distribution aliases."
}

variable "distribution_geo_restriction_type" {
  type        = string
  description = "CloudFront distribution geo restriction type."
  default     = "none"

  validation {
    condition     = contains(["blacklist", "whitelist", "none"], var.distribution_geo_restriction_type)
    error_message = "Geo restriction type does not match correct value."
  }
}

variable "distribution_geo_restriction_locations" {
  type        = list(string)
  description = "CloudFront distribution geo restriction locations."
  default     = []
}

variable "distribution_cache_viewer_protocol_policy" {
  type        = string
  description = "CloudFront distribution cache viewer protocol policy."
  default     = "redirect-to-https"

  validation {
    condition     = contains(["redirect-to-https", "allow-all", "https-only"], var.distribution_cache_viewer_protocol_policy)
    error_message = "Cache viewer protocol policy does not match correct value."
  }
}

variable "distribution_cache_allowed_methods" {
  type        = list(string)
  description = "CloudFront distribution cache allowed methods."
  default     = ["GET", "HEAD"]
}

variable "distribution_cache_cached_methods" {
  type        = list(string)
  description = "CloudFront distribution cached methods."
  default     = ["GET", "HEAD"]
}

variable "distribution_cache_min_ttl" {
  type        = number
  description = "CloudFront distribution, default cache behavior, min ttl."
  default     = 0
}

variable "distribution_cache_default_ttl" {
  type        = number
  description = "CloudFront distribution, default cache behavior, default ttl."
  default     = 3600
}

variable "distribution_cache_max_ttl" {
  type        = number
  description = "CloudFront distribution, default cache behavior, max ttl."
  default     = 86400
}

variable "distribution_cache_compress" {
  type        = bool
  description = "CloudFront distribution, default cache behavior, compress."
  default     = true
}

variable "distribution_cloudfront_default_certificate" {
  type        = bool
  description = "Define if CloudFront distribution uses the default certificate or not."
  default     = true
}

variable "distribution_minimum_protocol_version" {
  type        = string
  description = "CloudFront distribution minimum protocol version."
  default     = "TLSv1.2_2021"

  validation {
    condition     = contains(["TLSv1", "TLSv1_2016", "TLSv1.1_2016", "TLSv1.2_2019", "TLSv1.2_2021"], var.distribution_minimum_protocol_version)
    error_message = "Minimum protocol version does not match correct value."
  }
}

variable "distribution_ssl_support_method" {
  type        = string
  description = "CloudFront distribution SSL support method."
  default     = "sni-only"

  validation {
    condition     = contains(["sni-only", "vip"], var.distribution_ssl_support_method)
    error_message = "SSL support method does not match correct value."
  }
}

#
### route53

variable "dvo_allow_overwrite" {
  type        = bool
  description = "Define if route53 certificate validation allow overwrite or not."
  default     = true
}

variable "dvo_ttl" {
  type        = number
  description = "Define route53 certificate validation record TTL."
  default     = 60
}