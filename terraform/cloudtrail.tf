# --- CloudTrail作成 ---
# S3に管理イベント・S3オブジェクトの操作ログを保存（監査・解析用）
# CloudWatch Logsに管理イベントの操作ログを保存(解析・誤操作通知用）

resource "aws_cloudtrail" "webserver" {
  name           = "webserver-cloudtrail"
  s3_bucket_name = aws_s3_bucket.webserver[local.cloudtrail].id

  depends_on = [
    aws_s3_bucket_policy.bucket_policy
  ]

  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_logging                = var.enable_logging

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail.arn

  event_selector {
    read_write_type           = var.event_selector_read_write_type
    include_management_events = var.event_selector_include_management_events

    data_resource {
      type   = "AWS::S3::Object"
      values = ["${aws_s3_bucket.webserver[local.cloudtrail].arn}/"]
    }
  }
}
