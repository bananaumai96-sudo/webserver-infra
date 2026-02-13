# --- オートスケーリンググループ作成 ---
# マルチAZ配置により可用性を確保
# ALB配下でトラフィック分散
# ELBヘルスチェックによりアプリケーションレベルで異常検知
# 起動時にtag自動付与
resource "aws_autoscaling_group" "webserver" {
  name                      = "webserver-asg"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = module.network.ec2_subnet_ids
  health_check_type         = "ELB"
  health_check_grace_period = var.asg_health_check_grace_period

  launch_template {
    id      = aws_launch_template.webserver.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.webserver.arn]

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
