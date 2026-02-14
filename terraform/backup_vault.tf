# --- AWS Backup ボールト作成 ---
resource "aws_backup_vault" "webserver" {
  name = "webserver-backup-vault"
}
