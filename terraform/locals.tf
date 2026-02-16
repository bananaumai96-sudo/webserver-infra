locals {
  # --- 共通タグ ---
  common_tags = {
    Project   = var.project_name
    ManagedBy = "terraform"
  }

  # --- Auto Scaling Group用タグ ---
  asg_tags = merge(local.common_tags,
    {
      Name   = "webserver-ec2"
      Backup = "true"
  })

  # --- S3バケットポリシー ---
  s3_policy = {
    alb = {
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "ALBWrite"
          Effect = "Allow"
          Principal = {
            AWS = data.aws_elb_service_account.tokyo.arn
          }
          Action   = "s3:PutObject"
          Resource = "${aws_s3_bucket.webserver[local.alb].arn}/AWSLogs/${var.account_id}/*"
          Condition = {
            StringEquals = {
              "s3:x-amz-acl" = "bucket-owner-full-control"
            }
          }
        }
      ]
    }

    cloudfront = {
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "CloudFrontWrite"
          Effect = "Allow"
          Principal = {
            Service = "cloudfront.amazonaws.com"
          }
          Action   = "s3:PutObject"
          Resource = "${aws_s3_bucket.webserver[local.cloudfront].arn}/*"
          Condition = {
            StringEquals = {
              "s3:x-amz-acl" = "bucket-owner-full-control"
            }
          }
        }
      ]
    }

    cloudtrail = {
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "CloudTrailAclCheck"
          Effect = "Allow"
          Principal = {
            Service = "cloudtrail.amazonaws.com"
          }
          Action   = "s3:GetBucketAcl"
          Resource = aws_s3_bucket.webserver[local.cloudtrail].arn
        },
        {
          Sid    = "CloudTrailWrite"
          Effect = "Allow"
          Principal = {
            Service = "cloudtrail.amazonaws.com"
          }
          Action   = "s3:PutObject"
          Resource = "${aws_s3_bucket.webserver[local.cloudtrail].arn}/AWSLogs/*"
          Condition = {
            StringEquals = {
              "s3:x-amz-acl" = "bucket-owner-full-control"
            }
          }
        }
      ]
    }
  }

  # --- AWS Backup用 信頼ポリシー ---
  backup_role = {
    Version = "2012-10-17"
    Statement = [{
      Sid    = "AWSBackupService"
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  }

  # --- EC2用 信頼ポリシー ---
  ec2_role = {
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "EC2Service"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  }

  # --- EC2用 許可ポリシー ---
  ec2_policy = {
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "${aws_cloudwatch_log_group.ec2.arn}:*"
      }
    ]
  }

  # --- S3バケット用Key ---
  alb        = "alb"
  cloudfront = "cloudfront"
  cloudtrail = "cloudtrail"

  # --- CloudTrail用 信頼ポリシー
  cloudtrail_role_policy = {
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  }

  # --- CloudTrail用 許可ポリシー
  cloudtrail_iam_policy = {
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
    }]
  }

  # --- EC2用ユーザーデータ
  ec2_user_data = <<EOF
#!/bin/bash

# --- Webサーバーセットアップ ---
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Auto Scaling" > /var/www/html/index.html

# --- MariaDBセットアップ ---
sudo yum install -y dnf
sudo dnf update -y
sudo dnf install -y mariadb105

# --- rsyslog 設定 ---
sudo yum install -y rsyslog
sudo systemctl enable --now rsyslog

sudo mkdir -p /var/log/httpd
sudo tee /etc/rsyslog.d/10-httpd.conf > /dev/null <<'RSYSLOG_EOF'
# httpd.service のログを専用ファイルに書き出す
if $programname == 'systemd' then /var/log/httpd/httpd-system.log
& stop
RSYSLOG_EOF



sudo systemctl restart rsyslog

# --- CloudWatch Logs エージェントセットアップ ---
yum install -y amazon-cloudwatch-agent

# CloudWatch Agent 設定作成
cat <<CWCONFIG > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/httpd/httpd-system.log",
            "log_group_name": "/webserver/ec2",
            "log_stream_name": "{instance_id}-httpd-system",
            "timestamp_format": "%b %d %H:%M:%S"
          },
          {
            "file_path": "/var/log/httpd/access_log",
            "log_group_name": "/webserver/ec2",
            "log_stream_name": "{instance_id}-httpd-access",
            "timestamp_format": "%Y-%m-%d %H:%M:%S"
          },
          {
            "file_path": "/var/log/httpd/error_log",
            "log_group_name": "/webserver/ec2",
            "log_stream_name": "{instance_id}-httpd-error",
            "timestamp_format": "%Y-%m-%d %H:%M:%S"
          }
        ]
      }
    }
  }
}
CWCONFIG

# CloudWatch Agent 起動
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

EOF

}
