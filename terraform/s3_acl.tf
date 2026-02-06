resource "aws_s3_bucket_ownership_controls" "cloudfront_logs" {
  bucket = aws_s3_bucket.webserver[local.cloudfront].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "cloudfront_logs" {
  depends_on = [
    aws_s3_bucket_ownership_controls.cloudfront_logs
  ]
  
  bucket = aws_s3_bucket.webserver[local.cloudfront].id
  acl    = "log-delivery-write"
}
