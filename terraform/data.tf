data "aws_subnet" "private" {
  for_each = module.network.private_subnet
  id       = each.value.id
}
