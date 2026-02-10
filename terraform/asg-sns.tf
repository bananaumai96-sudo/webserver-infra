resource "aws_sns_topic" "asg_notifications" {
  name = "asg-notifications"
}

resource "aws_sns_topic_subscription" "asg_email" {
  topic_arn = aws_sns_topic.asg_notifications.arn
  protocol  = "email"
  endpoint  = var.email
}
