variable "cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "tag" {
  description = "共通タグ設定用"
  type        = map(string)
}

variable "ingress" {
  description = "EC2セキュリティグループの可変ポート設定用"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
  }))
}

variable "module_subnets" {
  description = "サブネット作成用"
  type        = map(object({
        az   = string
        cidr = string
        type = string
  }))

}
