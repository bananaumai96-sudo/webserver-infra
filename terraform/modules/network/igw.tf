#インターネットゲートウェイ作成
resource "aws_internet_gateway" "webserver" {
  vpc_id = aws_vpc.webserver.id
  tags = merge(var.module_tag,{Name = "webserver-igw"})
}
