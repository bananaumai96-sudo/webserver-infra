resource "aws_s3_bucket" "alb_log_bucket" {
  bucket = "werbserver-accesslogs-alb-20260204"
  tags = merge(local.common_tags,{Name = "webserver-s3-alb"})
}

resource "aws_s3_bucket_server_side_encryption_configuration" "log_alb_bucket_sse" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "log_alb_bucket_pab" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ログの古いものを自動削除（例：90日）
resource "aws_s3_bucket_lifecycle_configuration" "log_alb_bucket_lifecycle" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  rule {
    id     = "expire-logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_policy" "alb_logs_policy" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "logging.elb.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_log_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
