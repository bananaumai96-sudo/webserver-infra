# --- CloudWatch LogGroup作成 ---
resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/webserver/cloudtrail"
  retention_in_days = var.cloudtrail_log_retention_in_days
}

resource "aws_cloudwatch_log_group" "ec2" {
  name              = "/webserver/ec2"
  retention_in_days = var.ec2_log_retention_in_days
}

resource "aws_cloudwatch_log_group" "rds_error" {
  name              = "/aws/rds/instance/${var.rds_id}/error"
  retention_in_days = var.rds_error_log_retention_in_days
}

resource "aws_cloudwatch_log_group" "rds_slowquery" {
  name              = "/aws/rds/instance/${var.rds_id}/slowquery"
  retention_in_days = var.rds_slowquery_log_retention_in_days
}
