resource "aws_backup_selection" "webserver" {
  name         = "webserver-selection"
  plan_id      = aws_backup_plan.webserver.id
  iam_role_arn = aws_iam_role.webserver_backup_role.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}
