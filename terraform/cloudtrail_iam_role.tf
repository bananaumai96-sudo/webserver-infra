# --- CloudTrail用ロールにCloudWatch Logsの許可ポリシーを追加
resource "aws_iam_role_policy" "cloudtrail" {
  role   = aws_iam_role.cloudtrail.id
  policy = jsonencode(local.cloudtrail_iam_policy)
}
