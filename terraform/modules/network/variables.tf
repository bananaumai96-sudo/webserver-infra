variable "cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "tag" {
  description = "tag"
  type        = map(string)
}

variable "ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
  }))
}

variable "module_subnets" {
  description = "subnets"
  type        = map(object({
        az   = string
        cidr = string
        type = string
  }))

}