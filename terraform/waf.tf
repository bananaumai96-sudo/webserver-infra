resource "aws_wafv2_web_acl" "cloudfront" {
  provider = aws.use1

  name  = "cloudfront-web-acl"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "cloudfront-web-acl"
    sampled_requests_enabled   = true
  }

rule {
    name     = "AWSManagedCommon"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-common"
      sampled_requests_enabled   = true
    }
  }

rule {
  name     = "RateLimit"
  priority = 10

  action {
    block {}
  }

  statement {
    rate_based_statement {
      limit              = 1000
      aggregate_key_type = "IP"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "rate-limit"
    sampled_requests_enabled   = true
  }
}

}
