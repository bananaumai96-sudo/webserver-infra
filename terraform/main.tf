module "main" {
  source = "./modules/main"
  cidr = var.vpc_cidr
  availability_zones = var.azs
  ingress = var.web_ingress
  tag = local.common_tags
}
