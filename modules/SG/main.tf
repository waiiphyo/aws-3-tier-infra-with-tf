#External ALB Security Group
resource "aws_security_group" "ALB-SG" {
    vpc_id = var.vpc_id
    name = "ALB-SG"
    description = "ALB Security Group for Three-Tier Web application"

    tags = {
      Name = "ALB-SG"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

#Internal ALB Security Group
/*resource "aws_security_group" "internal-lb" {
    vpc_id = var.vpc_id
    name = "ALB-Internal"
    description = "Internal ALB SG"

    tags = {
      Name = "Internal-ALB"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

}
*/

#Jump host Security Group
resource "aws_security_group" "jmp-sg" {
    vpc_id = var.vpc_id
    name = "jmp-sg"
    description = "Jump host security group"

    tags = {
        Name = "jmp-sg"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ] 
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}

#Frontend Security Group
resource "aws_security_group" "FE-SG" {
    vpc_id = var.vpc_id
    name = "FE-SG"
    description = "Front-end application security group"

    tags = {
      Name = "FE-SG"
    }

}

resource "aws_security_group_rule" "HTTP" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = aws_security_group.ALB-SG.id
    security_group_id = aws_security_group.FE-SG.id
  
}

resource "aws_security_group_rule" "SSH" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = aws_security_group.jmp-sg.id
    security_group_id = aws_security_group.FE-SG.id
  
}

resource "aws_security_group_rule" "out" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.FE-SG.id
  
}

#Application tier security group
/*
resource "aws_security_group" "app-sg" {
    vpc_id = var.vpc_id
    name = "app-sg"
    tags = {
      Name = "APP-SG"
    }
}

resource "aws_security_group_rule" "app-ingress" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = aws_security_group.internal-lb.id
    security_group_id = aws_security_group.app-sg.id
  
}

resource "aws_security_group_rule" "ssh-jmp" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = aws_security_group.jmp-sg.id
    security_group_id = aws_security_group.app-sg.id
  
}

resource "aws_security_group_rule" "app-egress" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.app-sg.id
  
}
*/