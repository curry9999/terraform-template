module "prod" {
  source           = "../../../modules/s3"
  s3_bucket_name   = "mac-backup-bucket-000000001"
  s3_bucket_env    = "Prod"
  aws_profile_name = "terraform-prod"
}
