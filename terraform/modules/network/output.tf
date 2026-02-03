output "vpc_id"{
    description = "VPC_ID"
    value = aws_vpc.webserver.id
}

output "vpc_cidr"{
    description = "VPC_CIDR"
    value = aws_vpc.webserver.cidr_block
}

output "public_subnet"{
    description = "public_subnet"
    value = aws_subnet.public
}

output "private_subnet"{
    description = "private_subnet"
    value = aws_subnet.private
}

output "public_subnet_ids"{
    description = "public_subnet_ids"
    value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids"{
    description = "private_subnet_ids"
    value = [for s in aws_subnet.private : s.id]
}

output "security_group_alb_id"{
    description = "security_groups_alb_id"
    value = aws_security_group.alb.id
}

output "security_group_ec2_id"{
    description = "security_groups_ec2_id"
    value = aws_security_group.ec2_private.id
}

