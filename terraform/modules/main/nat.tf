#NATゲートウェイ用Elastic IP作成
resource "aws_eip" "nat" {
  for_each = var.availability_zones
  domain = "vpc"
  tags = merge(var.tag,{Name = "webserver-eip"})
}

#NATゲートウェイ作成
resource "aws_nat_gateway" "webserver" {
  for_each = aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = merge(var.tag,{Name = "webserver-nat"})

}
