resource "aws_iam_role_policy_attachment" "terraform" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.terraform_iam_policy.arn
}

resource "aws_iam_role_policy_attachment" "terraform_network" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.terraform_network_iam_policy.arn
}

