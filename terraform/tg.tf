resource "aws_lb_target_group" "webserver" {
  name     = "webserver-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = module.network.vpc_id

  health_check {
    path                = var.tg_health_check_path
    interval            = var.tg_health_check_interval
    timeout             = var.tg_health_check_timeout
    healthy_threshold   = var.tg_health_check_healthy_threshold
    unhealthy_threshold = var.tg_health_check_unhealthy_threshold
    matcher             = var.tg_health_check_matcher
  }

  tags = merge(local.common_tags,{Name = "webserver-alb-tg"})
}
