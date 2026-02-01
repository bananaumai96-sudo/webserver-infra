data "aws_subnet" "private" {
  for_each = module.main.private_subnet
  id       = each.value.id
}

resource "aws_instance" "webserver" {
  for_each = module.main.private_subnet
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = each.value.id
  vpc_security_group_ids = [module.main.security_group_ec2]
  associate_public_ip_address = false
  key_name = var.key_pair_name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }
  tags = merge(local.common_tags,{Name = "webserver-ec2-${split("-",data.aws_subnet.private[each.key].availability_zone)[2]}"})
}
