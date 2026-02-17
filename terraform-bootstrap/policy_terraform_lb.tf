data "aws_iam_policy_document" "terraform_lb_policy" {
  statement {
    sid       = "elbActions"
    effect    = "Allow"
    actions   = local.elb_Actions
    resources = ["*"]
  }
}
resource "aws_iam_policy" "terraform_lb_policy" {
  name   = "terraform_lb_policy"
  policy = data.aws_iam_policy_document.terraform_lb_policy.json
  tags   = merge(local.common_tags, { Name = "webserver-terraform-lb-policy" })
}
