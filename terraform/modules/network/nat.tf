# --- Publicサブネット（AZ単位）ごとにNAT用Elastic IPを作成 ---
resource "aws_eip" "nat" {
  for_each = local.public_subnets
  domain = "vpc"
  tags = merge(var.tag,{Name = "webserver-eip"})
}

# --- Publicサブネット（AZ単位）ごとにNAT Gatewayを作成 ---
resource "aws_nat_gateway" "webserver" {
  for_each = local.public_subnets
  
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = merge(var.tag,{Name = "webserver-nat"})

}
