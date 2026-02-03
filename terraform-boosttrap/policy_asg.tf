data "aws_iam_policy_document" "asg_policy" {
  statement {
        sid    = "asgActions"
        effect = "Allow"
        actions = local.asg_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "asg_action" {
  name   = "asg-action"
  policy = data.aws_iam_policy_document.asg_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-asg-policy"})
}
