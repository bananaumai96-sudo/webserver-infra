# --- CloudFront ディストリビューション 作成 ---
# originはALBを指定（Webサーバーの前段にCDNを配置）
# WAF(Web-ACL)を関連付け
# 証明書関連付け
# アクセスログをS3へ保存（監査・解析用）

resource "aws_cloudfront_distribution" "webserver" {
  enabled = true
  aliases = ["${var.domain_name}"]

  origin {
    domain_name = aws_lb.webserver.dns_name
    origin_id   = "alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"

      origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "alb-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET", "HEAD", "OPTIONS",
      "PUT", "POST", "PATCH", "DELETE"
    ]

    cached_methods = ["GET", "HEAD"]
    
    cache_policy_id = aws_cloudfront_cache_policy.static.id
    origin_request_policy_id   = aws_cloudfront_origin_request_policy.static.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate_validation.webserver_cloudfront.certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  web_acl_id = aws_wafv2_web_acl.cloudfront.arn

  logging_config {
    bucket          = aws_s3_bucket.webserver[local.cloudfront].bucket_domain_name
    prefix          = "cloudfront/"
    include_cookies = false
  }

}
