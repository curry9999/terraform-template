resource "aws_s3_bucket" "main" {
  bucket = "mac-backup-bucket-000000001"

  tags = {
    Name        = "Mac to S3 Backup Bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
