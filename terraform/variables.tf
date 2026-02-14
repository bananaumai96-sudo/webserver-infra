# --- modules --- 
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
  description = "EC2セキュリティグループの可変ポート設定用"
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

variable "subnets" {
  description = "サブネット作成用"
  type = map(object({
    az   = string
    cidr = string
    type = string
  }))

}
# --- modules ---

# --- Launch_Template --- 
variable "ami" {
  description = "起動するEC2インスタンスのAMI ID"
  type        = string
}

variable "instance_type" {
  description = "起動するEC2インスタンスのタイプ（例: t3.micro）"
  type        = string
}

variable "root_volume_size" {
  description = "ルートEBSボリュームのサイズ（GB）"
  type        = number

}

variable "root_volume_type" {
  description = "ルートEBSボリュームのタイプ（例: gp3）"
  type        = string
}
# --- Launch_Template ---

# --- Auto Scaling Group --- 
variable "asg_policy_type" {
  description = "スケーリングポリシーの種類（例: TargetTrackingScaling）"
  type        = string
}

variable "asg_metric_type" {
  description = "スケーリング判断に使用するメトリクスタイプ（例: ASGAverageCPUUtilization）"
  type        = string
}

variable "asg_target_value" {
  description = "ターゲット追跡スケーリングのリソース使用率閾値"
  type        = number
  default     = 50.0
}

variable "asg_min_size" {
  description = "Auto Scaling Group の最小インスタンス数"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Auto Scaling Group の最大インスタンス数"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "通常時に維持するインスタンス数"
  type        = number
  default     = 2
}

variable "asg_health_check_grace_period" {
  description = "インスタンス起動後、ヘルスチェックを開始するまでの待機時間（秒）"
  type        = number
  default     = 300
}
# --- Auto Scaling Group ---

# --- アカウントID ---
variable "account_id" {
  description = "account_id"
  type        = string
}
# --- アカウントID ---

# --- e-mailアドレス --- 
variable "email" {
  description = "email"
  type        = string
}
# --- e-mailアドレス ---

# --- ターゲットグループ --- 
variable "tg_health_check_path" {
  description = "ヘルスチェックでアクセスするパス"
  type        = string
  default     = "/"
}

variable "tg_health_check_interval" {
  description = "ヘルスチェックを実行する間隔（秒）"
  type        = number
  default     = 30
}

variable "tg_health_check_timeout" {
  description = "ヘルスチェック応答を待つ最大時間（秒）"
  type        = number
  default     = 5
}

variable "tg_health_check_healthy_threshold" {
  description = "正常と判定するまでに必要な連続成功回数"
  type        = number
  default     = 3
}

variable "tg_health_check_unhealthy_threshold" {
  description = "異常と判定するまでに必要な連続失敗回数"
  type        = number
  default     = 3
}

variable "tg_health_check_matcher" {
  description = "正常とみなすHTTPステータスコード（例: 200, 200-299）"
  type        = string
  default     = "200"
}
# --- ターゲットグループ ---

# --- S3 --- 
variable "s3_bucket_name" {
  description = "作成するS3バケット名の定義（用途ごとに指定一意にすること）"
  type        = map(string)
}

variable "s3_expire_days" {
  description = "オブジェクトを自動削除するまでの日数（バケット用途ごとに指定）"
  type        = map(number)
}

# --- S3 ---

# --- WAF(WebACL) --- 
variable "web_acl_name" {
  description = "WAF（WebACL）の名前（リージョン内で一意にすること）"
  type        = string
}

variable "web_acl_metric_name" {
  description = "WAF（WebACL） 全体のCloudWatchメトリクス名（WebALC内で一意にすること）"
  type        = string
}

variable "web_acl_managedcommon_metric_name" {
  description = "AWS Managed Rules（Common Rule Set）用のCloudWatchメトリクス名（WebALC内で一意にすること）"
  type        = string
}


variable "web_acl_ratelimit_limit" {
  description = "5分間に許可するリクエスト数の上限（IP単位のレート制限）"
  type        = number
}

variable "web_acl_ratelimit_metric_name" {
  description = "レート制限ルール用のCloudWatchメトリクス名（WebALC内で一意にすること）"
  type        = string
}
# --- WAF(WebACL) ---


# --- RDS --- 
variable "rds_instance_class" {
  description = "RDSインスタンスのサイズ（例: db.t3.micro）"
  type        = string
}

variable "rds_allocated_storage" {
  description = "割り当てるストレージ容量（GB）"
  type        = number
}

variable "rds_password" {
  description = "RDSマスターユーザーのパスワード"
  type        = string
}

# --- RDS ---

# --- CloudTrail --- 
variable "cloudtrail_metric_filter" {
  description = "CloudTrailログから特定イベントを検知するCloudWatch Logsメトリクスフィルタの定義"
  type = map(object({
    name        = string
    pattern     = string
    metric_name = string
    namespace   = string
  }))
}

variable "cloudtrail_comparison_operator" {
  description = "アラーム発報の比較演算（例: GreaterThanOrEqualToThreshold）"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "cloudtrail_evaluation_periods" {
  description = "アラーム判定に必要な連続評価回数"
  type        = number
  default     = 1
}

variable "cloudtrail_period" {
  description = "メトリクスを評価する間隔（秒）"
  type        = number
  default     = 300
}

variable "cloudtrail_statistic" {
  description = "アラーム評価に使用する統計方法（例: Sum, Average）"
  type        = string
  default     = "Sum"
}

variable "cloudtrail_threshold" {
  description = "アラーム発報するしきい値"
  type        = number
  default     = 1
}

variable "include_global_service_events" {
  description = "IAMやCloudFrontなどグローバルサービスのイベントを記録するか"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "全リージョンのイベントを記録するか"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "CloudTrailログ記録を有効化するか"
  type        = bool
  default     = true
}

variable "event_selector_read_write_type" {
  description = "記録するイベント種別（ReadOnly / WriteOnly / All）"
  type        = string
  default     = "All"
}

variable "event_selector_include_management_events" {
  description = "IAM操作など管理イベントを記録するか"
  type        = bool
  default     = true
}
# --- CloudTrail ---

# --- AWS Backup ---
variable "backup_plan_rule_name" {
  description = "バックアッププランのルール名"
  type        = string
}

variable "backup_lifecycle" {
  description = "バックアップの保持期間（日数）※期限後に自動削除"
  type        = number
  default     = 30
}

variable "backup_schedule" {
  description = "バックアップ実行スケジュール（cron形式・UTC指定）"
  type        = string
  default     = "cron(0 15 * * ? *)"
}

# --- AWS Backup ---

# --- CloudWatch LogGroup---
variable "cloudtrail_log_retention_in_days" {
  description = "CloudTrailログの保持期間（日数）"
  type        = number
  default     = 14
}

variable "ec2_log_retention_in_days" {
  description = "EC2ログの保持期間（日数）"
  type        = number
  default     = 14
}

# --- CloudWatch LogGroup---
