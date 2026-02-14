# --- EC2インスタンスプロファイル作成 ---
resource "aws_iam_instance_profile" "ec2_cloudwatch_profile" {
  name = "ec2-cloudwatch-logs-profile"
  role = aws_iam_role.ec2_cw_role.name
}
