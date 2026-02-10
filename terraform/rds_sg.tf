resource "aws_db_subnet_group" "webserver" {
  name       = "webserver-rds-sg"
  subnet_ids = module.network.rds_subnet_ids
  tags = merge(local.common_tags,{Name = "webserver-rds-sg"})
}
