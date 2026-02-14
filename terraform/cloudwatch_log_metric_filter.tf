# --- CloudTrail用CloudTrail Logs Metric Filter作成 ---
# 以下の誤操作のメトリクスを作成
# -rootユーザー使用
# -IAMユーザー作成
# -アクセスキー作成
# -セキュリティグループのインバウンドルールを全開放で作成
# -CloudTrail停止

resource "aws_cloudwatch_log_metric_filter" "cloudtrail" {
  for_each       = var.cloudwatch_log_metric_filter
  name           = each.value.name
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = each.value.pattern

  metric_transformation {
    name      = each.value.metric_name
    namespace = each.value.namespace
    value     = "1"
  }
}
