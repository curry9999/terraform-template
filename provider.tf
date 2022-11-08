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
