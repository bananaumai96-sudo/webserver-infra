locals {
  common_tags = {
    Project   = var.project_name
    ManagedBy = "terraform"
  }
 az_split = {
    for k, subnet in data.aws_subnet.private :
    k => split("-", subnet.availability_zone)[2]
  }

public_subnet_ids = [
  for subnet in values(module.network.public_subnet) : 
  subnet.id
]

}
