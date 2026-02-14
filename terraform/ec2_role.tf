# --- EC2インスタンスプロファイル用のロール作成 ---
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name               = "ec2-cloudwatch-logs-role"
  assume_role_policy = jsonencode(local.ec2_role)
}

resource "aws_iam_policy" "ec2_cloudwatch_policy" {
  name   = "ec2-cloudwatch-logs-policy"
  policy = jsonencode(local.ec2_policy)
}

resource "aws_iam_role_policy_attachment" "ec2_cw_attach" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = aws_iam_policy.ec2_cloudwatch_policy.arn
}
