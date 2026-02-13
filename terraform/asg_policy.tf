# --- オートスケーリングポリシー作成 ---
# 指定メトリクスを一定値に維持するよう自動スケール
# CPU使用率を基準に水平スケーリング
resource "aws_autoscaling_policy" "asg_scale_policy" {
  name                   = "asg-scale-policy"
  autoscaling_group_name = aws_autoscaling_group.webserver.name
  policy_type            = var.asg_policy_type

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.asg_metric_type
    }
    target_value = var.asg_target_value
  }
}
