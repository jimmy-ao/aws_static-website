# s3

resource "aws_s3_bucket" "bucket" {
  bucket = join("-", [var.bucket, random_id.ids.hex])

  force_destroy = var.force_destroy

  tags = var.bucket_tags
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.bucket_block_public_acls
  block_public_policy     = var.bucket_block_public_policy
  ignore_public_acls      = var.bucket_ignore_public_acls
  restrict_public_buckets = var.bucket_restrict_public_buckets

}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = data.aws_iam_policy_document.bucket_policy_document.json
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.index_document_suffix
  }

  error_document {
    key = var.error_document_key
  }
}

#
### s3 objects

resource "aws_s3_object" "objects" {
  for_each = fileset("./app/dist", "**")

  bucket = aws_s3_bucket.bucket.id

  key          = each.value
  source       = join("/", ["./app/dist", each.value])
  etag         = filemd5(join("/", ["./app/dist", each.value]))
  content_type = lookup(local.content_types, element(split(".", each.value), length(split(".", each.value)) - 1), "text/html")
}
