terraform {
  cloud {
    organization = "curry9999"
    hostname     = "app.terraform.io"

    workspaces {
      name = "mac-to-s3-backup"
    }
  }
}
