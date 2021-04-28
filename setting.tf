terraform {
  required_version = ">=0.14.8"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  bucket_name = "33399738-4324-4e98-bf4a-20f99df00ea4"
  project_name = "example-api-gateway-with-cloudfront"
}
