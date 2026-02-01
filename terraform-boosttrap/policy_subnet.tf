data "aws_iam_policy_document" "subnet_policy" {
  statement {
        sid    = "subnetActions"
        effect = "Allow"
        actions = local.subnet_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "subnet_action" {
  name   = "subnet-action"
  policy = data.aws_iam_policy_document.subnet_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-subnet-policy"})
}
