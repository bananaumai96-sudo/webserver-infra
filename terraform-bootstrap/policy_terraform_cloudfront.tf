data "aws_iam_policy_document" "terraform_cloudfront_policy" {
  statement {
    sid       = "cloudfrontActions"
    effect    = "Allow"
    actions   = local.cloudfornt_Actions
    resources = ["*"]
  }

  statement {
    sid       = "wafActions"
    effect    = "Allow"
    actions   = local.waf_Actions
    resources = ["*"]
  }
}
resource "aws_iam_policy" "terraform_cloudfront_policy" {
  name   = "terraform_cloudfront_policy"
  policy = data.aws_iam_policy_document.terraform_cloudfront_policy.json
  tags   = merge(local.common_tags, { Name = "webserver-terraform-cloudfront-policy" })
}
