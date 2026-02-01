data "aws_iam_policy_document" "VPC_policy" {
  statement {
        sid    = "VPCActions"
        effect = "Allow"
        actions = local.VPC_Actions
        resources = ["*"]
      }
}

resource "aws_iam_policy" "VPC_action" {
  name   = "VPC-action"
  policy = data.aws_iam_policy_document.VPC_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-VPC-policy"})
}
