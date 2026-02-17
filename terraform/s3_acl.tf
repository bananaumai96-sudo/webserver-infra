# --- CloudFront用S3バケット ACL設定 ---
resource "aws_s3_bucket_ownership_controls" "cloudfront_bucket" {
  bucket = aws_s3_bucket.webserver[local.cloudfront].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "cloudfront_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.cloudfront_bucket
  ]

  bucket = aws_s3_bucket.webserver[local.cloudfront].id
  acl    = "log-delivery-write"
}
