# --- RDS用パラメーターグループ作成 ---
# UTF-8 4バイトの文字を格納可能
# 検索時大文字小文字を区別しない
# タイムゾーンを日本に設定
resource "aws_db_parameter_group" "webserver" {
  family = "mysql8.4"
  name   = "webserver-mysql8-pg"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }
}
