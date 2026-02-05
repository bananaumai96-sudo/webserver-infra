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
        sid    = "VPCActions"
        effect = "Allow"
        actions = local.VPC_Actions
        resources = ["*"]
      }

      statement {
        sid    = "subnetActions"
        effect = "Allow"
        actions = local.subnet_Actions
        resources = ["*"]
      }

      statement {
        sid    = "sgActions"
        effect = "Allow"
        actions = local.sg_Actions
        resources = ["*"]
      }

      statement {
        sid    = "rtgActions"
        effect = "Allow"
        actions = local.rtb_Actions
        resources = ["*"]
      }

      statement {
        sid    = "s3Actions"
        effect = "Allow"
        actions = local.s3_Actions
        resources = ["*"]
      }

      statement {
        sid    = "natActions"
        effect = "Allow"
        actions = local.nat_Actions
        resources = ["*"]
      }

      statement {
        sid    = "igwActions"
        effect = "Allow"
        actions = local.igw_Actions
        resources = ["*"]
      }

      statement {
        sid    = "elbActions"
        effect = "Allow"
        actions = local.elb_Actions
        resources = ["*"]
      }

      statement {
        sid    = "eipActions"
        effect = "Allow"
        actions = local.eip_Actions
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

}

resource "aws_iam_policy" "terraform_iam_policy" {
  name   = "terraform_iam_policy"
  policy = data.aws_iam_policy_document.terraform_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-terraform-policy"})
}
