resource "aws_iam_role_policy_attachment" "EC2" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.EC2_create_delete.arn
}

resource "aws_iam_role_policy_attachment" "igw" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.igw_action.arn
}

resource "aws_iam_role_policy_attachment" "nat" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.nat_action.arn
}

resource "aws_iam_role_policy_attachment" "rtb" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.rtb_action.arn
}

resource "aws_iam_role_policy_attachment" "sg" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.sg_action.arn
}

resource "aws_iam_role_policy_attachment" "subnet" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.subnet_action.arn
}

resource "aws_iam_role_policy_attachment" "VPC" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.VPC_action.arn
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.s3_action.arn
}

resource "aws_iam_role_policy_attachment" "eip" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.eip_action.arn
}

resource "aws_iam_role_policy_attachment" "elb" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = aws_iam_policy.elb_action.arn
}
