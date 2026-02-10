locals {
  common_tags = {
    Project   = var.project_name
    ManagedBy = "terraform"
  }

  asg_tags = merge(local.common_tags,
    {
      Name = "webserver-ec2"
    })

s3_policy = {
    alb = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_elb_service_account.tokyo.arn
        }
        Action = "s3:PutObject"
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
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:PutObject"
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
        Sid    = "AWSCloudTrailAclCheck"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.webserver[local.cloudtrail].arn
      },
      {
        Sid    = "AWSCloudTrailWrite"
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

alb = "alb"
cloudfront = "cloudfront"
cloudtrail = "cloudtrail"

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



 ec2_user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Auto Scaling" > /var/www/html/index.html
sudo yum install -y dnf
sudo dnf update -y
sudo dnf install -y mariadb105
EOF
}
