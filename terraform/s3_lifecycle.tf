resource "aws_s3_bucket_lifecycle_configuration" "log_alb_bucket_lifecycle" {
  for_each = aws_s3_bucket.webserver
  bucket = each.value.id

  rule {
    id     = "expire-logs"
    status = "Enabled"

    expiration {
      days = var.s3_expire_days[each.key]
    }
  }
}
