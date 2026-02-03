resource "aws_lb" "webserver" {
  name               = "webserver-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.network.security_group_alb_id]
  subnets            = module.network.public_subnet_ids

  tags = merge(local.common_tags,{Name = "webserver-alb"})
}
