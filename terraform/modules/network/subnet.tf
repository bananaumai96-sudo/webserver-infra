# --- サブネット作成 ---
resource "aws_subnet" "webserver" {
  for_each = var.module_subnets
  vpc_id            = aws_vpc.webserver.id
  availability_zone = each.value.az
  cidr_block = each.value.cidr
  map_public_ip_on_launch = false
  assign_ipv6_address_on_creation = false
  tags = merge(var.module_tag,
    {
      Name = "webserver-${each.value.type}-subnet-${each.value.az}"
      Type = each.value.type
    }
  )
}
