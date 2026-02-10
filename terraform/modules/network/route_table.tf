# public用ルートテーブル作成
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.tag,{Name = "webserver-public-route-table"})

}

# デフォルトルート 0.0.0.0/0 → IGW
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.webserver.id
}

# public subnet に紐付け
resource "aws_route_table_association" "public" {
  for_each       = local.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# ec2用ルートテーブル作成
resource "aws_route_table" "ec2" {
  for_each = local.ec2_subnets
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.tag,{Name = "webserver-ec2-route-table-${each.value.availability_zone}"})

}

# デフォルトルート 0.0.0.0/0 → Nat
resource "aws_route" "ec2_route" {
  for_each = local.ec2_subnets
  route_table_id         = aws_route_table.ec2[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.webserver[each.key].id
}

# ec2用subnetに紐付け
resource "aws_route_table_association" "ec2" {
  for_each       = local.ec2_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.ec2[each.key].id
}

# rds用ルートテーブル作成
resource "aws_route_table" "rds" {
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.tag,{Name = "webserver-rds-route-table"})

}

# rds用subnetに紐付け
resource "aws_route_table_association" "rds" {
  for_each       = local.rds_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rds.id
}
