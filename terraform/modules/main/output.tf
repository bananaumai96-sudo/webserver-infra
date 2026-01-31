output "vpc_id"{
    description = "VPC_ID"
    value = aws_vpc.webserver.id

}

output "vpc_cidr"{
    description = "VPC_CIDR"
    value = aws_vpc.webserver.cidr_block
}

output "public_subnet_ids"{
    description = "public_subnet_ids"
    value = aws_subnet.public[*].id
}

output "public_subnet_availability_zones"{
    description = "public_subnet_availability_zones"
    value = aws_subnet.public[*].availability_zone
}

output "private_subnet_ids"{
    description = "private_subnet_ids"
    value = aws_subnet.private[*].id
}

output "private_subnet_availability_zones"{
    description = "private_subnet_availability_zones"
    value = aws_subnet.private[*].availability_zone
}

output "security_group_alb"{
    description = "security_groups_alb"
    value = aws_security_group.alb.id
}

output "security_group_ec2"{
    description = "security_groups_ec2"
    value = aws_security_group.ec2_private.id
}
