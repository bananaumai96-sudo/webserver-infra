#ALB用セキュリティグループ作成
resource "aws_security_group" "alb" {
  name        = "werbserver-sg-alb"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.webserver.id

  egress {
    protocol    = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tag,{Name = "webserver-sg-alb"})
}


#EC2用セキュリティグループ作成
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

#rds用セキュリティグループ作成
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
