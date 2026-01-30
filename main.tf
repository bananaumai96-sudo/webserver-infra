resource "aws_vpc" "webserver" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "webserver"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.webserver.id
  cidr_block        = var.private_subnet_cidrs
  availability_zone = var.AZ-1a

  tags = {
    Name = "webserver-infra-private-1a"
  }
}
