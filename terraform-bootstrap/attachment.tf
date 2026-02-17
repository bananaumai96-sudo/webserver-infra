# ---IAMポリシーをロールにアタッチ
# 以下制限があるためポリシーを分けて実装
# ロールにアタッチできるIAMポリシー10個まで
# Jsonファイルの容量制限
resource "aws_iam_role_policy_attachment" "terraform" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}

resource "aws_iam_role_policy_attachment" "terraform_network" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.terraform_network_policy.arn
}

resource "aws_iam_role_policy_attachment" "terraform_sv" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.terraform_sv_policy.arn
}

resource "aws_iam_role_policy_attachment" "terraform_lb" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.terraform_lb_policy.arn
}

resource "aws_iam_role_policy_attachment" "terraform_cloudfront" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.terraform_cloudfront_policy.arn
}
