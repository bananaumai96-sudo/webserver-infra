# --- VPC作成 ---
resource "aws_vpc" "webserver" {
  cidr_block = var.module_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  assign_generated_ipv6_cidr_block = false
  tags = merge(var.module_tag,{Name = "webserver-vpc"})
}
