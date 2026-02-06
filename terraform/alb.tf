resource "aws_lb" "webserver" {
  name               = "webserver-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.network.security_group_alb_id]
  subnets            = module.network.public_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.webserver[local.alb].id
    enabled = true
  }

  tags = merge(local.common_tags,{Name = "webserver-alb"})
}
