variable "project_name" {
  description = "Project name"
  type        = string
  default     = "webserver_portfolio"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "azs" {
  description = "availability_zones"
  type        = list(string)
}

variable "web_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
  }))
}

variable "ami" {
  description = "ami"
  type    = string
}

variable "instance_type" {
  description = "instance_type"
  type    = string
}

variable "root_volume_size" {
  description = "root_volume_size"
  type    = number
  
}

variable "root_volume_type" {
  description = "root_volume_type"
  type    = string
}