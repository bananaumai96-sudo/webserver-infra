resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_sse" {
  for_each = aws_s3_bucket.webserver
  bucket   = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
