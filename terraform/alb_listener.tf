# --- ALBリスナー作成 ---
# 443番ポートで受信
# ターゲットグループへフォワード
resource "aws_lb_listener" "https" {
  depends_on = [
    aws_acm_certificate_validation.webserver_alb
  ]
  
  load_balancer_arn = aws_lb.webserver.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = aws_acm_certificate.webserver_alb.arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.webserver.arn
  }
}
