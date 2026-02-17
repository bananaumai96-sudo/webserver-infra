# --- IAMポリシー作成 ---
# modulesリソース一覧
data "aws_iam_policy_document" "terraform_network_policy" {
  statement {
    sid       = "VPCActions"
    effect    = "Allow"
    actions   = local.VPC_Actions
    resources = ["*"]
  }

  statement {
    sid       = "subnetActions"
    effect    = "Allow"
    actions   = local.subnet_Actions
    resources = ["*"]
  }

  statement {
    sid       = "sgActions"
    effect    = "Allow"
    actions   = local.sg_Actions
    resources = ["*"]
  }

  statement {
    sid       = "rtbActions"
    effect    = "Allow"
    actions   = local.rtb_Actions
    resources = ["*"]
  }

  statement {
    sid       = "igwActions"
    effect    = "Allow"
    actions   = local.igw_Actions
    resources = ["*"]
  }

  statement {
    sid       = "eipActions"
    effect    = "Allow"
    actions   = local.eip_Actions
    resources = ["*"]
  }

  statement {
    sid       = "natActions"
    effect    = "Allow"
    actions   = local.nat_Actions
    resources = ["*"]
  }
}

resource "aws_iam_policy" "terraform_network_policy" {
  name   = "terraform_network_policy"
  policy = data.aws_iam_policy_document.terraform_network_policy.json
  tags   = merge(local.common_tags, { Name = "webserver-terraform-network-policy" })
}