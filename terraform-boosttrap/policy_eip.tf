data "aws_iam_policy_document" "eip_policy" {
  statement {
        sid    = "eipActions"
        effect = "Allow"
        actions = local.eip_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "eip_action" {
  name   = "eip-action"
  policy = data.aws_iam_policy_document.eip_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-eip-policy"})
}
