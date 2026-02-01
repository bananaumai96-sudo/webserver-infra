data "aws_iam_policy_document" "nat_policy" {
  statement {
        sid    = "natActions"
        effect = "Allow"
        actions = local.nat_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "nat_action" {
  name   = "nat-action"
  policy = data.aws_iam_policy_document.nat_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-nat-policy"})
}
