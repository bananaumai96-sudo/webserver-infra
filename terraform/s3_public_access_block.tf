# --- S3バケット　パブリックアクセスブロック設定 ---
resource "aws_s3_bucket_public_access_block" "log_cloudfront_bucket_pab" {
  for_each = aws_s3_bucket.webserver
  bucket   = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
