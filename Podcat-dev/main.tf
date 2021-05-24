terraform {
  backend "s3" {
    bucket        = "tfstatefile442"
    key           = "workspace/terraform.tfstate"
    region        = "us-east-1"
    encrypt       = true
    profile       = "local"
  }
}

module "security_group_alb" {
  source = "../modules/SG"
  sg_name = var.podcat_sg_name_alb
  sg_description = var.podcat_sg_description_alb
  vpc_id = data.aws_vpc.podcat-vpc.id
  default_tags = var.default_tags
  sg_ingress_rules_cidr = var.sg_ingress_rules_cidr_alb
  sg_egress_rules_cidr = var.sg_egress_rules_cidr
  sg_egress_rules_sgid = var.sg_egress_rules_sgid
  sg_ingress_rules_sgid = var.sg_ingress_rules_sgid
  sg_ingress_rules_prefixid = var.sg_ingress_rules_prefixid
  sg_egress_rules_prefixid = var.sg_egress_rules_prefixid
  sg_egress_rules_self = var.sg_egress_rules_self
  sg_ingress_rules_self = var.sg_ingress_rules_self
}


data aws_security_group "bastion_sg"{
  id = var.bastionhost_sgid
}

locals {
  sg_ingress_rules_sgid_ec2= ["22,22,tcp,${data.aws_security_group.bastion_sg.id}, bastion_sg_id","80,80,tcp,${module.security_group_ec2.security_group_id},testing_sg_2"]
}

module "security_group_ec2" {
  source = "../modules/SG"
  sg_name = var.podcat_sg_name_ec2
  sg_description = var.podcat_sg_description_ec2
  vpc_id = data.aws_vpc.podcat-vpc.id
  default_tags = var.default_tags
  sg_ingress_rules_cidr = var.sg_ingress_rules_cidr
  sg_egress_rules_cidr = var.sg_egress_rules_cidr
  sg_egress_rules_sgid = var.sg_egress_rules_sgid
  sg_ingress_rules_sgid = local.sg_ingress_rules_sgid_ec2
  sg_ingress_rules_prefixid = var.sg_ingress_rules_prefixid
  sg_egress_rules_prefixid = var.sg_egress_rules_prefixid
  sg_egress_rules_self = var.sg_egress_rules_self
  sg_ingress_rules_self = var.sg_ingress_rules_self
}

data "aws_vpc" "podcat-vpc" {
  default = true
}
/*
data "aws_route53_zone" "bento" {
  name = var.route53_zone_name
}

module "route53_rec" {
  source = "../modules/Route53"
  name = var.route53record_name
  type = var.route53_record_type
  zone_id = data.aws_route53_zone.bento.id
  evaluate_target_health = var.evaluate_target_health
  target_zone_id = module.load_balancer.alb_zone_id
  target_name = module.load_balancer.alb_dnsname

}
*/
module "EC2" {
  source = "../modules/EC2"
  ami = var.ami
  default_tags = var.default_tags
  instance_type = var.instance_type
  vpc_security_group_ids = [module.security_group_ec2.security_group_id]
}

module "load_balancer" {
  source = "../modules/LB"

  # aws_lb
  load_balancer_type = var.load_balancer_type
  lb_name = var.lb_name
  internal = var.internal
  ip_address_type = var.ip_address_type
  security_groups = [module.security_group_alb.security_group_id]
  subnets = var.alb_subnet
  enable_deletion_protection = var.enable_deletion_protection
  enable_http2 = var.enable_http2
  default_tags = var.default_tags

  tg_name = var.tg_name
  vpc_id = data.aws_vpc.podcat-vpc.id
  tg_port = var.tg_port
  tg_protocol = var.tg_protocol
  target_type = var.target_type

  alb_port = var.alb_port
  alb_protocol = var.alb_protocol
  alb_ssl_policy = var.alb_ssl_policy

  tg_attachment_ec2_target_id = module.EC2.ec2_instance_id
  tg_attachment_port = var.tg_attachment_port

}
