variable "region" {
  description = "AWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
   description = "private_subnetのCIDRブロック"
   type        = string
  default     =  "10.0.1.0/24"
}

variable "AZ-1a" {
  description = "private_subnet_1aのAZ"
  type        = string
  default     = "ap-northeast-1a"
}

