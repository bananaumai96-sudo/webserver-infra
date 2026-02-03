resource "aws_autoscaling_group" "webserver" {
  name                      = "webserver-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = module.network.private_subnet_ids
  health_check_type         = "ELB"
  health_check_grace_period = 300

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
