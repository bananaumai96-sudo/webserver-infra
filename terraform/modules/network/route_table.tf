# --- パブリックサブネット用ルートテーブル作成 ---
# Internet Gateway経由で外部通信をするためのルートテーブル
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.tag,{Name = "webserver-public-route-table"})

}

# --- ルート 0.0.0.0/0 → IGW ---
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.webserver.id
}

# --- パブリックサブネットに紐付け ---
resource "aws_route_table_association" "public" {
  for_each       = local.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# --- EC2用ルートテーブル作成 ---
# NAT Gateway経由で外部通信をするためのルートテーブル
resource "aws_route_table" "ec2" {
  for_each = local.ec2_subnets
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.tag,{Name = "webserver-ec2-route-table-${each.value.availability_zone}"})

}

# --- ルート 0.0.0.0/0 → NAT Gateway ---
resource "aws_route" "ec2_route" {
  for_each = local.ec2_subnets
  route_table_id         = aws_route_table.ec2[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.webserver[each.key].id
}

# --- EC2用サブネットに紐付け ---
resource "aws_route_table_association" "ec2" {
  for_each       = local.ec2_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.ec2[each.key].id
}

# --- RDS用ルートテーブル作成 ---
# RDSはインターネットに出る必要がないため、外部向けルートは設定しない
resource "aws_route_table" "rds" {
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.tag,{Name = "webserver-rds-route-table"})

}

# --- RDS用サブネットに紐付け ---
resource "aws_route_table_association" "rds" {
  for_each       = local.rds_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rds.id
}
