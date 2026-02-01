data "aws_iam_policy_document" "EC2_policy" {
  statement {
        sid    = "EC2LifecycleActions"
        effect = "Allow"
        actions = local.EC2_Lifecycle_Actions
        resources = ["*"]
      }

      statement {
        sid    = "EC2DescribeActions"
        effect = "Allow"
        actions = local.EC2_Describe_Actions
        resources = ["*"]
      }

      statement {
        sid    = "EC2Tagging"
        effect = "Allow"
        actions = local.EC2_Tagging
        resources = ["*"]
      }
}

resource "aws_iam_policy" "EC2_create_delete" {
  name   = "EC2-create-delete"
  policy = data.aws_iam_policy_document.EC2_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-ec2-policy"})
}
