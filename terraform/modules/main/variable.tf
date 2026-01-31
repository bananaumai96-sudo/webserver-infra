variable "cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "availability_zones" {
  description = "availability_zones"
  type        = list(string)
}

variable "tag" {
  description = "tag"
  type        = map(string)
}
