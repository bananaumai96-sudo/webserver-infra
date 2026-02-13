resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/webserver/cloudtrail"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "ec2" {
  name              = "/webserver/ec2"
  retention_in_days = 14
}
