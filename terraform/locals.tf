locals {
  common_tags = {
    Project   = var.project_name
    ManagedBy = "terraform"
  }

  asg_tags = merge(local.common_tags,
    {
      Name = "webserver-ec2"
    })

 ec2_user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Auto Scaling" > /var/www/html/index.html
EOF

}
