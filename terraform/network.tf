# --- ./module/networkのリソース作成 ---
module "network" {
  source         = "./modules/network"
  module_cidr    = var.vpc_cidr
  module_ingress = var.web_ingress
  module_tag     = local.common_tags
  module_subnets = var.subnets
}
