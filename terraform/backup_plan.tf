# --- AWS Backup　バックアッププラン作成 ---
resource "aws_backup_plan" "webserver" {
  name = "webserver-backup-plan"

  rule {
    rule_name         = var.backup_plan_rule_name
    target_vault_name = aws_backup_vault.webserver.name
    schedule          = var.backup_schedule

    lifecycle {
      delete_after = var.backup_lifecycle
    }
  }
}
