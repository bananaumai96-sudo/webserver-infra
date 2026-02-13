resource "aws_iam_instance_profile" "ec2_cw_profile" {
  name = "ec2-cloudwatch-logs-profile"
  role = aws_iam_role.ec2_cw_role.name
}
