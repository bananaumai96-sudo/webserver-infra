# --- CloudFrontのマネージドプレフィックスリスト参照用 ---
# ALBのセキュリティグループで使用
data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

# --- ALB用セキュリティグループ作成 ---
resource "aws_security_group" "alb" {
  name        = "werbserver-sg-alb"
  description = "Allow HTTP from CloudFront"
  vpc_id      = aws_vpc.webserver.id

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
        prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  }

  egress {
    protocol    = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tag,{Name = "webserver-sg-alb"})
}


# --- EC2用セキュリティグループ作成 ---
# インターネットからの直接アクセスを防ぎ、ALB経由のみ通信を許可する設計
# 可変ポート対応のため dynamic block を使用
resource "aws_security_group" "ec2_private" {
  name        = "werbserver-sg-ec2"
  description = "Allow sg-alb"
  vpc_id      = aws_vpc.webserver.id

dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      security_groups = [aws_security_group.alb.id]
    }
  }

  egress {
    protocol    = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tag,{Name = "webserver-sg-ec2"})
}

# --- RDS用セキュリティグループ作成 ---
# DBは直接公開せず、EC2からの3306通信のみ許可
resource "aws_security_group" "rds_private" {
  name        = "werbserver-sg-rds"
  description = "Allow sg-ec2"
  vpc_id      = aws_vpc.webserver.id

ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "TCP"
      security_groups = [aws_security_group.ec2_private.id]
  }

  egress {
    protocol    = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tag,{Name = "webserver-sg-rds"})
}
