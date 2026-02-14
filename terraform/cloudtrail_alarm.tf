# --- CloudTrail用CloudWatch Alarm作成 ---
# 以下の誤操作時SNSにて通知
# -rootユーザー使用
# -IAMユーザー作成
# -アクセスキー作成
# -セキュリティグループのインバウンドルールを全開放で作成
# -CloudTrail停止

resource "aws_cloudwatch_metric_alarm" "cloudtrail_security_alarm" {
  for_each            = aws_cloudwatch_log_metric_filter.cloudtrail
  alarm_name          = each.key
  comparison_operator = var.cloudtrail_comparison_operator
  evaluation_periods  = var.cloudtrail_evaluation_periods
  metric_name         = var.cloudwatch_log_metric_filter[each.key].metric_name
  namespace           = var.cloudwatch_log_metric_filter[each.key].namespace
  period              = var.cloudtrail_period
  statistic           = var.cloudtrail_statistic
  threshold           = var.cloudtrail_threshold

  alarm_actions = [aws_sns_topic.cloudtrail_security_alert.arn]
}
