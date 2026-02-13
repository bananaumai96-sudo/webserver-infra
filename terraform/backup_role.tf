resource "aws_iam_role" "webserver_backup_role" {
  name               = "webserver-backup-role"
  assume_role_policy = jsonencode(local.backup_role)

}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.webserver_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
