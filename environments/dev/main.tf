module "dev" {
  source = "../../modules/template"
  s3_bucket_name = "mac-backup-bucket-000000001"
  s3_bucket_env = "Prod"
}
