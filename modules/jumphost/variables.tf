variable "vpc-id" {
  
}

variable "sg" {
  
}

variable "subnet" {
  
}

variable "instance_ami" {
  default = "ami-06a0cd9728546d178"
}

variable "instance_type" {
  default     = "t2.micro"
}

variable "instance_name" {
  default = "jump-host"
}
