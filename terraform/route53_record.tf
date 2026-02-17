# --- ドメイン検証用レコード作成 ---
# webserver用ドメインの証明書
resource "aws_route53_record" "cloudfront_domain_validation" {
  for_each = {
    for dvo in aws_acm_certificate.webserver_cloudfront.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.webserver.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

# --- Aレコード作成 ---
# webserver用ドメイン
# CloudFrontディストリビューションへのエイリアス
# シンプルルーティング
resource "aws_route53_record" "webserver" {
  zone_id = aws_route53_zone.webserver.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.webserver.domain_name
    zone_id                = aws_cloudfront_distribution.webserver.hosted_zone_id
    evaluate_target_health = false
  }
}
