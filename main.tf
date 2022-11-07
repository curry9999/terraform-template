terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.38.0"
    }
  }
  cloud {
    organization = "curry9999"
    hostname     = "app.terraform.io"

    workspaces {
      name = "mac-to-s3-backup"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "terraform-sso-profile"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-000000001"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
