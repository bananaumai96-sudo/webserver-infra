resource "aws_iam_role" "cloudtrail" {
 name = "cloudtrail-cloudwatch-role"
 assume_role_policy = jsonencode(local.cloudtrail_role_policy)
}
