variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "availability_zones" {
  description = "private_subnetの作成用"
  type        = list(string)
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "webserver_portfolio"
}
