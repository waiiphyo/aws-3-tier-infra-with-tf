output "alb-security_groups-id" {
    value = resource.aws_security_group.ALB-SG.id
  
}

output "fe-sg" {
    value = resource.aws_security_group.FE-SG.id
  
}

output "jmp-sg" {
    value = resource.aws_security_group.jmp-sg.id
  
}

/*
output "internal-lb-sg" {
    value = resource.aws_security_group.internal-lb.id
  
}

output "app-sg" {
    value = resource.aws_security_group.app-sg.id
  
}
*/