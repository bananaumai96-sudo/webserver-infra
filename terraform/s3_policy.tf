resource "aws_s3_bucket_policy" "cloudfront_logs_policy"{
  for_each = aws_s3_bucket.webserver
  bucket = each.value.id

  policy = jsonencode(local.s3_policy[each.key])
}
