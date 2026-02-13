resource "aws_wafv2_web_acl" "cloudfront" {
  provider = aws.use1

  name  = var.web_acl_name
  scope = "CLOUDFRONT"

  # Web ACL 全体のデフォルトアクション
  default_action {
    allow {}
  }

  # Web ACL 全体の可視性設定
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.web_acl_metric_name
    sampled_requests_enabled   = true
  }

  # -------------------------
  # ルール1: AWS Managed Common
  # -------------------------
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
      metric_name                = var.web_acl_managedcommon_metric_name
      sampled_requests_enabled   = true
    }
  }

  # -------------------------
  # ルール2: Rate Limit
  # -------------------------
  rule {
    name     = "RateLimit"
    priority = 10

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = var.web_acl_ratelimit_limit
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = var.web_acl_ratelimit_metric_name
      sampled_requests_enabled   = true
    }
  }

}
