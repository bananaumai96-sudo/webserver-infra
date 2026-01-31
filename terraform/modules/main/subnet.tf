#publicサブネット作成
resource "aws_subnet" "public" {
  for_each = toset(var.availability_zones)
  vpc_id            = aws_vpc.webserver.id
  availability_zone = each.value
  cidr_block = cidrsubnet(aws_vpc.webserver.cidr_block,8,index(var.availability_zones,each.value) + 10)
  map_public_ip_on_launch = true
  assign_ipv6_address_on_creation = false
  tags = merge(var.tag,{Name = "webserver-private-subnet-${split("-",each.value)[2]}"})
}

#privateサブネット作成
resource "aws_subnet" "private" {
  for_each = toset(var.availability_zones)
  vpc_id            = aws_vpc.webserver.id
  availability_zone = each.value
  cidr_block = cidrsubnet(aws_vpc.webserver.cidr_block,8,index(var.availability_zones,each.value))
  map_public_ip_on_launch = false
  assign_ipv6_address_on_creation = false
  tags = merge(var.tag,{Name = "webserver-private-subnet-${split("-",each.value)[2]}"})
}
