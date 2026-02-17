# --- Route53ホストゾーン作成 ---
resource "aws_route53_zone" "webserver" {
  name = var.domain_name
  tags = merge(local.common_tags, { Name = "webserver-route53" })
}