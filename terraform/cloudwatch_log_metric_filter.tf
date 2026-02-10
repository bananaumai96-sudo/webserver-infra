resource "aws_cloudwatch_log_metric_filter" "cloudtrail" {
  for_each = var.cloudwatch_log_metric_filter
  name           = each.value.name
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = each.value.pattern

  metric_transformation {
    name      = each.value.metric_name
    namespace = each.value.namespace
    value     = "1"
  }
}
