# --- 証明書検証 ---
resource "aws_acm_certificate_validation" "webserver_cloudfront" {
  provider        = aws.use1
  certificate_arn = aws_acm_certificate.webserver_cloudfront.arn
  validation_record_fqdns = [
    for record in aws_route53_record.cloudfront_domain_validation :
    record.fqdn
  ]
}

resource "aws_acm_certificate_validation" "webserver_alb" {
  certificate_arn = aws_acm_certificate.webserver_alb.arn
  validation_record_fqdns = [
    for record in aws_route53_record.cloudfront_domain_validation :
    record.fqdn
  ]
}
