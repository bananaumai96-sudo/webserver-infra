# --- ALBリスナー作成 ---
# 80番ポートで受信
# ターゲットグループへフォワード
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.webserver.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver.arn
  }
}
