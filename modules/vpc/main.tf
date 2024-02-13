resource "aws_vpc" "Web-VPC" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = var.vpc_name
    }
    enable_dns_hostnames = true
}

resource "aws_subnet" "public-sub1" {
    depends_on = [ 
        aws_vpc.Web-VPC,
     ]
    cidr_block = var.public_sub1_cidr
    availability_zone = "us-east-1a"
    vpc_id = aws_vpc.Web-VPC.id
    tags = {
      Name = var.public_sub1_name
    }
}

resource "aws_subnet" "public-sub2" {
    depends_on = [ aws_vpc.Web-VPC,
    
     ]
    cidr_block = var.public_sub2_cidr
    availability_zone = "us-east-1b"
    vpc_id = aws_vpc.Web-VPC.id
    tags = {
      Name = var.public_sub2_name
    }
  
}

resource "aws_subnet" "private-sub1" {
    depends_on = [ aws_vpc.Web-VPC,
    
     ]
    availability_zone = "us-east-1a"
    cidr_block = var.private_sub1_cidr
    vpc_id = aws_vpc.Web-VPC.id
    tags = {
      Name = var.private_sub1_name
    }
  
}

resource "aws_subnet" "private-sub2" {
    depends_on = [ aws_vpc.Web-VPC,
    
     ]
    availability_zone = "us-east-1b"
    cidr_block = var.private_sub2_cidr
    vpc_id = aws_vpc.Web-VPC.id
    tags = {
      Name = var.private_sub2_name
    }
  
}

resource "aws_internet_gateway" "web-igw" {
    depends_on = [ aws_vpc.Web-VPC,
    
     ]
    vpc_id = aws_vpc.Web-VPC.id
    tags = {
      Name = var.igw_name
    }
}

resource "aws_eip" "nat-eip" {
    domain = "vpc"
    tags = {
      Name = "nat-ip"
    }
  
}

resource "aws_nat_gateway" "web-nat" {
    depends_on = [ 
        aws_vpc.Web-VPC,
        aws_eip.nat-eip
    
     ]
    subnet_id = aws_subnet.public-sub1.id
    allocation_id = aws_eip.nat-eip.id
    tags = {
      Name = var.nat_name
    }

}

resource "aws_route_table" "public-route" {
    depends_on = [ 
        aws_vpc.Web-VPC,
        aws_internet_gateway.web-igw,
     ]
    vpc_id = aws_vpc.Web-VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.web-igw.id
    }
    tags = {
      Name = var.public_route_table
    }
  
}

resource "aws_route_table_association" "public-route-asso1" {
    depends_on = [ 
        aws_vpc.Web-VPC,
        aws_route_table.public-route,
        aws_subnet.public-sub1,
     ]
    
    subnet_id = aws_subnet.public-sub1.id
    route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public-route-asso2" {
    depends_on = [ 
        aws_vpc.Web-VPC,
        aws_route_table.public-route,
        aws_subnet.public-sub2,
     ]
    
    subnet_id = aws_subnet.public-sub2.id
    route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.Web-VPC.id
  
}

resource "aws_route" "nat-gw-route" {
  route_table_id = aws_route_table.private-route.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.web-nat.id
  
}

resource "aws_route_table_association" "private-route-asso1" {
    depends_on = [ 
        aws_vpc.Web-VPC,
        aws_route_table.private-route,
        aws_subnet.private-sub1,
     ]
    
    #count = 2
    subnet_id = aws_subnet.private-sub1.id
    route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "private-route-asso2" {
    depends_on = [ 
        aws_vpc.Web-VPC,
        aws_route_table.private-route,
        aws_subnet.private-sub2
     ]
    
    #count = 2
    subnet_id = aws_subnet.private-sub2.id
    route_table_id = aws_route_table.private-route.id
}

