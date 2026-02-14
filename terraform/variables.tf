#modulesで使用=======================================
variable "project_name" {
  description = "Project name"
  type        = string
  default     = "webserver_portfolio"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}


variable "web_ingress" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

variable "subnets" {
  type = map(object({
    az   = string
    cidr = string
    type = string
  }))

}
#==================================================

#launch_templateで使用==================================================
variable "ami" {
  description = "ami"
  type        = string
}

variable "instance_type" {
  description = "instance_type"
  type        = string
}

variable "root_volume_size" {
  description = "root_volume_size"
  type        = number

}

variable "root_volume_type" {
  description = "root_volume_type"
  type        = string
}
#=====================================================================

#asgで使用==================================================
variable "asg_policy_type" {
  description = "asg_policy_type"
  type        = string
}

variable "asg_metric_type" {
  description = "asg_metric_type"
  type        = string
}

variable "asg_target_value" {
  description = "asg_target_value"
  type        = number
  default     = 50.0
}

variable "asg_min_size" {
  description = "asg_min_size"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "asg_max_size"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "asg_desired_capacity"
  type        = number
  default     = 2
}

variable "asg_health_check_grace_period" {
  description = "asg_health_check_grace_period"
  type        = number
  default     = 300
}
#==================================================

#アカウントID=======================================
variable "account_id" {
  description = "account_id"
  type        = string
}
#==================================================

#e-mailアドレス=====================================
variable "email" {
  description = "email"
  type        = string
}
#==================================================

#ターゲットグループで使用==================================================
variable "tg_health_check_path" {
  description = "tg_health_check_path"
  type        = string
  default     = "/"
}

variable "tg_health_check_interval" {
  description = "tg_health_check_interval"
  type        = number
  default     = 30
}

variable "tg_health_check_timeout" {
  description = "tg_health_check_ timeout"
  type        = number
  default     = 5
}

variable "tg_health_check_healthy_threshold" {
  description = "tg_health_check_healthy_threshold"
  type        = number
  default     = 3
}

variable "tg_health_check_unhealthy_threshold" {
  description = "tg_health_check_unhealthy_threshold"
  type        = number
  default     = 3
}

variable "tg_health_check_matcher" {
  description = "tg_health_check_matcher"
  type        = string
  default     = "200"
}
#===================================================================

#s3で使用==================================================
variable "s3_bucket_name" {
  description = "s3_bucket_name"
  type        = map(string)
}

variable "s3_expire_days" {
  description = "s3_expire_days"
  type        = map(number)
}

#==================================================

#webaclで使用======================================
variable "web_acl_name" {
  description = "web_acl_name"
  type        = string
}

variable "web_acl_metric_name" {
  description = "web_acl_metric_name"
  type        = string
}

variable "web_acl_managedcommon_metric_name" {
  description = "web_acl_managedcommon_metric_name"
  type        = string
}


variable "web_acl_ratelimit_limit" {
  description = "web_acl_ratelimit_limit"
  type        = number
}

variable "web_acl_ratelimit_metric_name" {
  description = "web_acl_ratelimit_metric_name"
  type        = string
}
#==================================================


#rdsで使用======================================
variable "rds_instance_class" {
  description = "rds_instance_class"
  type        = string
}

variable "rds_allocated_storage" {
  description = "web_acl_name"
  type        = number
}

variable "rds_password" {
  description = "rds_password"
  type        = string
}

#============================================

#cloudtrailで使用=============================
variable "cloudwatch_log_metric_filter" {
  description = "cloudwatch_log_metric_filter"
  type = map(object({
    name        = string
    pattern     = string
    metric_name = string
    namespace   = string
  }))
}

variable "cloudtrail_comparison_operator" {
  description = "cloudtrail_comparison_operator"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "cloudtrail_evaluation_periods" {
  description = "cloudtrail_evaluation_periods"
  type        = number
  default     = 1
}

variable "cloudtrail_period" {
  description = "cloudtrail_period"
  type        = number
  default     = 300
}

variable "cloudtrail_statistic" {
  description = "cloudtrail_statistic"
  type        = string
  default     = "Sum"
}

variable "cloudtrail_threshold" {
  description = "cloudtrail_threshold"
  type        = number
  default     = 1
}

variable "include_global_service_events" {
  description = "include_global_service_events"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "is_multi_region_trail"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "enable_logging"
  type        = bool
  default     = true
}

variable "event_selector_read_write_type" {
  description = "event_selector_read_write_type"
  type        = string
  default     = "All"
}

variable "event_selector_include_management_events" {
  description = "event_selector_include_management_events"
  type        = bool
  default     = true
}
#============================================

# --- AWS Backup ---
variable "backup_rule_name" {
  description = "tg_health_check_interval"
  type        = string
}

variable "backup_lifecycle" {
  description = "tg_health_check_interval"
  type        = number
  default     = 30
}

variable "backup_schedule" {
  description = "tg_health_check_interval"
  type        = string
  default     = "cron(10 9 * * ? *)"  # 毎日18:10 JST
}

# --- AWS Backup ---

# --- Cloud Watch ---
variable "cloudwatch_log_group_cloudtrail" {
  description = "tg_health_check_interval"
  type        = number
  default     = 14
}

variable "cloudwatch_log_group_ec2" {
  description = "tg_health_check_interval"
  type        = number
  default     = 14
}

# --- Cloud Watch ---
