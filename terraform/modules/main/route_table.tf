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
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# private用ルートテーブル作成
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.tag,{Name = "webserver-private-route-table"})

}

# デフォルトルート 0.0.0.0/0 → Nat
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.webserver.id
}

# private subnet に紐付け
resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
