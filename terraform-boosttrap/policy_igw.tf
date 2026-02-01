data "aws_iam_policy_document" "igw_policy" {
  statement {
        sid    = "igwActions"
        effect = "Allow"
        actions = local.igw_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "igw_action" {
  name   = "igw-action"
  policy = data.aws_iam_policy_document.igw_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-igw-policy"})
}
