# --- ACM　CloudFront用証明書リクエスト ---
resource "aws_acm_certificate" "webserver_cloudfront" {
  provider = aws.use1
  domain_name               = var.domain_name
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true 
  }
  tags = merge(local.common_tags, { Name = "webserver-acm-cloudfront" })
}

# --- ACM　ALB用証明書リクエスト ---
resource "aws_acm_certificate" "webserver_alb" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true 
  }
  tags = merge(local.common_tags, { Name = "webserver-acm-alb" })
}
