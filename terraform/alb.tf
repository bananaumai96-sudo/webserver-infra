# --- ALB作成 ---
# パブリックサブネットに配置
# アクセスログをS3へ保存（監査・解析用）
resource "aws_lb" "webserver" {
  name = "webserver-alb"

  #インターネット向けにするためfalse
  internal = false

  load_balancer_type = "application"
  security_groups    = [module.network.security_group_alb_id]
  subnets            = module.network.public_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.webserver[local.alb].id
    enabled = true
  }

  tags = merge(local.common_tags, { Name = "webserver-alb" })
}
