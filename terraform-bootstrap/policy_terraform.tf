data "aws_iam_policy_document" "terraform_policy" {
  statement {
        sid    = "EC2Actions"
        effect = "Allow"
        actions = local.EC2_Actions
        resources = ["*"]
      }
      
      statement {
        sid    = "cloudfrontActions"
        effect = "Allow"
        actions = local.cloudfornt_Actions
        resources = ["*"]
      }

      statement {
        sid    = "asgActions"
        effect = "Allow"
        actions = local.asg_Actions
        resources = ["*"]
      }

      statement {
        sid    = "s3Actions"
        effect = "Allow"
        actions = local.s3_Actions
        resources = ["*"]
      }

      statement {
        sid    = "elbActions"
        effect = "Allow"
        actions = local.elb_Actions
        resources = ["*"]
      }

      statement {
        sid    = "wafActions"
        effect = "Allow"
        actions = local.waf_Actions
        resources = ["*"]
      }

      statement {
        sid    = "snsActions"
        effect = "Allow"
        actions = local.sns_Actions
        resources = ["*"]
      }

      statement {
        sid    = "rdsActions"
        effect = "Allow"
        actions = local.rds_Actions
        resources = ["*"]
      }

      statement {
        sid    = "iamActions"
        effect = "Allow"
        actions = local.iam_Actions
        resources = ["*"]
      }

      statement {
        sid    = "cloudwatchActions"
        effect = "Allow"
        actions = local.cloudwatch_Actions
        resources = ["*"]
      }

      statement {
        sid    = "cloudtrailActions"
        effect = "Allow"
        actions = local.cloudtrail_Actions
        resources = ["*"]
      }

}

resource "aws_iam_policy" "terraform_iam_policy" {
  name   = "terraform_iam_policy"
  policy = data.aws_iam_policy_document.terraform_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-terraform-policy"})
}
