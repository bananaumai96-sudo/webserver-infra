data "aws_iam_policy_document" "elb_policy" {
  statement {
        sid    = "elbActions"
        effect = "Allow"
        actions = local.elb_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "elb_action" {
  name   = "elb-action"
  policy = data.aws_iam_policy_document.elb_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-elb-policy"})
}
