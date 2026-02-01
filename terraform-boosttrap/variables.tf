variable "user_name" {
  description = "user name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "webserver_portfolio"
}

variable "s3_bucket" {
  description = "s3 bucket"
  type        = string
}
