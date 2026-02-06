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
