output "vpc_id"{
    description = "VPC_ID"
    value = aws_vpc.webserver.id
}

output "public_subnet_ids"{
    description = "public_subnet_ids"
    value = local.public_subnet_ids
}

output "ec2_subnet_ids"{
    description = "private_subnet_ids"
    value = local.ec2_subnet_ids
}

output "rds_subnet_ids"{
    description = "private_subnet_ids"
    value = local.rds_subnet_ids
}

output "security_group_alb_id"{
    description = "security_groups_alb_id"
    value = aws_security_group.alb.id
}

output "security_group_ec2_id"{
    description = "security_groups_ec2_id"
    value = aws_security_group.ec2_private.id
}

output "security_group_rds_id"{
    description = "security_groups_rds_id"
    value = aws_security_group.rds_private.id
}
