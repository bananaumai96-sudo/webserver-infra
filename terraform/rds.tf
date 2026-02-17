# --- RDS作成 ---
# 検証環境向け設定
# - マルチAZは無効 (検証アカウントでは利用不可)
# - 削除可能 (deletion_protection = false)
# - 削除時スナップショット作成不要(skip_final_snapshot = true)

# 本番環境向け推奨設定
# - マルチAZは有効
# - 削除不可 (deletion_protection = true)
# - 削除時スナップショット作成(skip_final_snapshot = false)
# - 削除時スナップショット名（final_snapshot_identifier）
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


  multi_az            = false
  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false

  enabled_cloudwatch_logs_exports = [
    "error",
    "slowquery"
  ]

  tags = merge(local.common_tags, {
    Name   = "webserver-rds"
    Backup = "true"
  })
}
