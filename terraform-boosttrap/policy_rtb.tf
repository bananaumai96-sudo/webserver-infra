data "aws_iam_policy_document" "rtb_policy" {
  statement {
        sid    = "rtgActions"
        effect = "Allow"
        actions = local.rtb_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "rtb_action" {
  name   = "rtb-action"
  policy = data.aws_iam_policy_document.rtb_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-rtb-policy"})
}
