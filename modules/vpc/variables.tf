variable "vpc_cidr" {
    default = "192.168.0.0/16"
  
}

variable "vpc_name" {
    default = "web-vpc"
  
}

variable "public_sub1_cidr" {
    default = "192.168.10.0/24"
  
}

variable "public_sub1_name" {
    default = "web-pub-sub1"
}

variable "public_sub2_cidr" {
    default = "192.168.30.0/24"
  
}

variable "public_sub2_name" {
    default = "web-pub-sub2"
}

variable "private_sub1_cidr" {
    default = "192.168.60.0/24"
  
}

variable "private_sub1_name" {
    default = "web-priv-sub1"
}

variable "private_sub2_cidr" {
    default = "192.168.90.0/24"
  
}

variable "private_sub2_name" {
    default = "web-priv-sub2"
}

variable "igw_name" {
    default = "web-IGW"
  
}

variable "nat_name" {
    default = "web-nat"
  
}

variable "public_route_table" {
    default = "web-pub-route"
}

variable "private_route_table" {
    default = "web-priv-route"
  
}