module "network" {
  source         = "./modules/network"
  cidr           = var.vpc_cidr
  ingress        = var.web_ingress
  tag            = local.common_tags
  module_subnets = var.subnets
}
