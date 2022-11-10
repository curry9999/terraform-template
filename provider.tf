provider "aws" {
  region  = "ap-northeast-1"
  profile = "terraform-sso-profile"
}

terraform {
  cloud {
    organization = "curry9999"
    hostname     = "app.terraform.io"

    workspaces {
      name = "mac-to-s3-backup"
    }
  }
}
