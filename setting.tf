locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = "ap-northeast-1"
  bucket_name    = "e85ecd55-4419-4ea5-8a5f-dfef7a8b9241"
  project_name   = "example-api-gateway-with-cloudfront"
}

terraform {
  required_version = ">=0.14.8"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

data "aws_caller_identity" "current" {}
