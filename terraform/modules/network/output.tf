output "vpc_id"{
    description = "VPC_ID"
    value = aws_vpc.webserver.id
}

output "public_subnet_ids"{
    description = "パブリックサブネットID一覧"
    value = local.public_subnet_ids
}

output "ec2_subnet_ids"{
    description = "EC2用サブネットID一覧"
    value = local.ec2_subnet_ids
}

output "rds_subnet_ids"{
    description = "RDS用サブネットID一覧"
    value = local.rds_subnet_ids
}

output "security_group_alb_id"{
    description = "ALB用セキュリティグループID"
    value = aws_security_group.alb.id
}

output "security_group_ec2_id"{
    description = "EC2用セキュリティグループID"
    value = aws_security_group.ec2_private.id
}

output "security_group_rds_id"{
    description = "RDS用セキュリティグループID"
    value = aws_security_group.rds_private.id
}
