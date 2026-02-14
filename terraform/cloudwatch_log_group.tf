# --- CloudWatch ロググループ作成 ---
resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/webserver/cloudtrail"
  retention_in_days = var.cloudwatch_log_group_cloudtrail
}

resource "aws_cloudwatch_log_group" "ec2" {
  name              = "/webserver/ec2"
  retention_in_days = var.cloudwatch_log_group_ec2
}
