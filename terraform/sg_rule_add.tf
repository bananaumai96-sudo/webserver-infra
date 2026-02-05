resource "aws_security_group_rule" "alb_from_cloudfront" {
  type              = "ingress"
  security_group_id = module.network.security_group_alb_id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"

  prefix_list_ids = [
    data.aws_ec2_managed_prefix_list.cloudfront.id
  ]
}
