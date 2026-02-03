data "aws_iam_policy_document" "s3_policy" {
  statement {
        sid    = "s3BucketAccess"
        effect = "Allow"
        actions = local.s3_Bucket_Access_Actions
        resources = [var.s3_bucket]
      }

  statement {
        sid    = "s3ObjectAccess"
        effect = "Allow"
        actions = local.s3_Object_Access_Actions
        resources = ["${var.s3_bucket}/*"]
      }

}

resource "aws_iam_policy" "s3_action" {
  name   = "s3-action"
  policy = data.aws_iam_policy_document.s3_policy.json
  tags = merge(local.common_tags,{Name = "webserver-terraform-s3-policy"})
}
