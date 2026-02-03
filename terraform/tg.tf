resource "aws_lb_target_group" "webserver" {
  name     = "webserver-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = module.network.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = merge(local.common_tags,{Name = "webserver-alb-tg"})
}
