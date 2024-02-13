module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source = "./modules/SG"
  vpc_id = module.vpc.vpc-id
}

module "launch_template" {
  source = "./modules/launch_templates"
  sg-id = module.security_groups.fe-sg
}

module "autoscaling_group" {
  source = "./modules/ASG"
  vpcid = module.vpc.vpc-id
  template-id = module.launch_template.template-id
  template-version = module.launch_template.template-version
  subnet1 = module.vpc.privatesub1
  subnet2 = module.vpc.privatesub2
}

module "alb" {
  source = "./modules/ALB"
  pub-alb-security_groups-id = module.security_groups.alb-security_groups-id
  pub-sub1 = module.vpc.public-subnets1
  pub-sub2 = module.vpc.public-subnets2
  FE-TG = module.autoscaling_group.TG
  #pri-alb = module.security_groups.internal-lb-sg
  #pri-sub1 = module.vpc.privatesub1
  #pri-sub2 = module.vpc.privatesub2

}

module "jmp" {
  source = "./modules/jumphost"
  vpc-id = module.vpc.vpc-id
  subnet = module.vpc.public-subnets1
  sg = module.security_groups.jmp-sg
  
}