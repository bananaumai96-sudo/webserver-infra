
data "aws_iam_policy_document" "sg_policy" {
  statement {
        sid    = "sgActions"
        effect = "Allow"
        actions = local.sg_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "sg_action" {
  name   = "sg-action"
  policy = data.aws_iam_policy_document.sg_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-sg-policy"})
}
