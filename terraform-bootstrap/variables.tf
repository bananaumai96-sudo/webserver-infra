# --- IAMユーザー名 ---
variable "user_name" {
  description = "user name"
  type        = string
}

# --- プロジェクト名 ---
variable "project_name" {
  description = "Project name"
  type        = string
  default     = "webserver_portfolio"
}
