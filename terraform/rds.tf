resource "aws_db_instance" "webserver" {
  identifier = "webserver-rds"

  engine            = "MySql"
  engine_version    = "8.4.7"
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage
  storage_type      = "gp3"

  db_name  = "WebserverDB"
  username = "admin"
  password = var.rds_password

  db_subnet_group_name   = aws_db_subnet_group.webserver.name
  vpc_security_group_ids = [module.network.security_group_rds_id]
  parameter_group_name   = aws_db_parameter_group.webserver.name

  #マルチAZ設定(検証環境で有効にできないため無効)
  multi_az = false

  #publicアクセスなし
  publicly_accessible = false

  #ture=RDS即削除（バックアップなし）,false=RDS削除時スナップショット作成
  skip_final_snapshot = true

  #true=RDS削除不可,false=RDS削除可能
  deletion_protection = false

  tags = merge(local.common_tags, {
    Name   = "webserver-rds"
    Backup = "true"
  })
}
