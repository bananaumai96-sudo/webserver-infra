# --- オートスケール通知 ---
# スケールイン・スケールアウトのエラー発生時に通知を実行
# 通知過多を防ぐため、異常系のみ通知
resource "aws_autoscaling_notification" "webserver" {
  group_names = [
    aws_autoscaling_group.webserver.name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
  ]

  topic_arn = aws_sns_topic.asg_notifications.arn
}
