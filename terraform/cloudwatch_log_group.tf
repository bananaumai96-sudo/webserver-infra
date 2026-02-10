resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/cloudtrail/webserver"
  retention_in_days = 14
}
