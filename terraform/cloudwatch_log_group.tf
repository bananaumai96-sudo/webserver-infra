# --- CloudWatch LogGroup作成 ---
resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/webserver/cloudtrail"
  retention_in_days = var.cloudtrail_log_retention_in_days
}

resource "aws_cloudwatch_log_group" "ec2" {
  name              = "/webserver/ec2"
  retention_in_days = var.ec2_log_retention_in_days
}
