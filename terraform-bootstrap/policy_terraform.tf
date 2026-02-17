# --- IAMポリシー作成 ---
# modules・EC2・RDS以外のリソース用
data "aws_iam_policy_document" "terraform_policy" {
  statement {
    sid       = "asgActions"
    effect    = "Allow"
    actions   = local.asg_Actions
    resources = ["*"]
  }

  statement {
    sid       = "s3Actions"
    effect    = "Allow"
    actions   = local.s3_Actions
    resources = ["*"]
  }

  statement {
    sid       = "snsActions"
    effect    = "Allow"
    actions   = local.sns_Actions
    resources = ["*"]
  }

  statement {
    sid       = "iamActions"
    effect    = "Allow"
    actions   = local.iam_Actions
    resources = ["*"]
  }

  statement {
    sid       = "cloudwatchActions"
    effect    = "Allow"
    actions   = local.cloudwatch_Actions
    resources = ["*"]
  }

  statement {
    sid       = "cloudtrailActions"
    effect    = "Allow"
    actions   = local.cloudtrail_Actions
    resources = ["*"]
  }

  statement {
    sid       = "backupActions"
    effect    = "Allow"
    actions   = local.backup_Actions
    resources = ["*"]
  }

  statement {
    sid       = "kmsActions"
    effect    = "Allow"
    actions   = local.kms_Actions
    resources = ["*"]
  }

    statement {
    sid       = "acmActions"
    effect    = "Allow"
    actions   = local.acm_Actions
    resources = ["*"]
  }

    statement {
    sid       = "route53Actions"
    effect    = "Allow"
    actions   = local.route53_Actions
    resources = ["*"]
  }

}

resource "aws_iam_policy" "terraform_policy" {
  name   = "terraform_iam_policy"
  policy = data.aws_iam_policy_document.terraform_policy.json
  tags   = merge(local.common_tags, { Name = "webserver-terraform-policy" })
}
