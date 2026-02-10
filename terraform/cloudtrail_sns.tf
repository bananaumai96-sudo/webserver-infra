resource "aws_sns_topic" "cloudtrail_security_alert" {
  name = "cloudtrail_security-alert"
}

resource "aws_sns_topic_subscription" "cloudtraik_email" {
  topic_arn = aws_sns_topic.cloudtrail_security_alert.arn
  protocol  = "email"
  endpoint  = var.email
}
