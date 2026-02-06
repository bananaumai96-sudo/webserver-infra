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
}

alb = "alb"
cloudfront = "cloudfront"


 ec2_user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Auto Scaling" > /var/www/html/index.html
EOF

}
