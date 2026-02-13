data "aws_iam_policy_document" "terraform_policy_sv" {
  statement {
    sid       = "rdsActions"
    effect    = "Allow"
    actions   = local.rds_Actions
    resources = ["*"]
  }

  statement {
    sid       = "EC2Actions"
    effect    = "Allow"
    actions   = local.EC2_Actions
    resources = ["*"]
  }
}

resource "aws_iam_policy" "terraform_sv_iam_policy" {
  name   = "terraform_sv_iam_policy"
  policy = data.aws_iam_policy_document.terraform_policy_sv.json
  tags   = merge(local.common_tags, { Name = "webserver-terraform-terraform-policy_sv" })
}
