locals{
    # --- webserver用サブネットIDをTypeタグで分類し、list配列を作成 ---
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

    # --- webserver用サブネットをTypeタグで分類し、AZをキーとするmap(object)を作成 ---
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
