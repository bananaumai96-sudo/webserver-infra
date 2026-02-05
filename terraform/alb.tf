resource "aws_lb" "webserver" {
  name               = "webserver-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.network.security_group_alb_id]
  subnets            = module.network.public_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.alb_log_bucket.bucket
    enabled = true
    #prefix  = "AWSLogs/251456382610"
  }

  tags = merge(local.common_tags,{Name = "webserver-alb"})
}
