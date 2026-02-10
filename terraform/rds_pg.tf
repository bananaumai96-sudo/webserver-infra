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
