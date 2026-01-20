#  providers

# This provider will the main one

provider "aws" {
  region  = var.region
  profile = var.profile
}

# This provider will be used for creating the ACM certificate (CloudFront requires us-east-1)

provider "aws" {
  region  = "us-east-1"
  profile = var.profile
  alias   = "us-east-1"
}