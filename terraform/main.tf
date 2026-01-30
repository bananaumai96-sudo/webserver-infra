resource "aws_vpc" "webserver" {
  cidr_block = var.vpc_cidr

  tags =merge(
    local.common_tags,
    {
      Name = "webserver_vpc"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)
  vpc_id            = aws_vpc.webserver.id
  availability_zone = var.availability_zones[count.index]
  cidr_block = cidrsubnet(aws_vpc.webserver.cidr_block,8,count.index)

  tags = merge(
    local.common_tags,
    {
      Name = "webserver_private_subnet_${split("-", var.availability_zones[count.index])[2]}"
    }
  )
}
