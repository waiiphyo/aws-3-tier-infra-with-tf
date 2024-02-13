output "vpc-id" {
    value = resource.aws_vpc.Web-VPC.id
  
}

output "IGW-id" {
    value = resource.aws_internet_gateway.web-igw.id
  
}

output "NAT-id" {
    value = resource.aws_nat_gateway.web-nat.id
  
}

output "elastic-ip" {
    value = resource.aws_eip.nat-eip.address
  
}

output "public-subnets1" {
    value = resource.aws_subnet.public-sub1.id
  
}

output "public-subnets2" {
    value = resource.aws_subnet.public-sub2.id
  
}

output "privatesub1" {
  value = resource.aws_subnet.private-sub1.id
}

output "privatesub2" {
  value = resource.aws_subnet.private-sub2.id
}