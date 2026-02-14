# --- CloudTrail用SNSトピック作成 ---
# 誤操作を通知
# メールでアラートを受信
resource "aws_sns_topic" "cloudtrail_security_alert" {
  name = "cloudtrail_security-alert"
}

resource "aws_sns_topic_subscription" "cloudtrail_email" {
  topic_arn = aws_sns_topic.cloudtrail_security_alert.arn
  protocol  = "email"
  endpoint  = var.email
}
