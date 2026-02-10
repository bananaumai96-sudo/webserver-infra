locals{
    public_subnet_ids = [
        for s in aws_subnet.webserver :
        s.id if s.tags.Type == "Public"
    ]

    ec2_subnet_ids = [
        for s in aws_subnet.webserver :
        s.id if s.tags.Type == "ec2"
    ] 

    rds_subnet_ids = [
        for s in aws_subnet.webserver :
        s.id if s.tags.Type == "rds"
    ] 

    public_subnets = {
        for _, s in aws_subnet.webserver :
        s.availability_zone => s
        if s.tags.Type == "Public"
    }

    ec2_subnets = {
        for _, s in aws_subnet.webserver :
        s.availability_zone => s
        if s.tags.Type == "ec2"    
    }

    rds_subnets = {
        for _, s in aws_subnet.webserver :
        s.availability_zone => s
        if s.tags.Type == "rds"    
    }
}
