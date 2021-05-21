profile                   = "local"
aws_region                = "us-east-1"
bastionhost_sgid = "sg-84b0fc80"
podcat_sg_name_alb          = "podcat-sow-sg-alb"
podcat_sg_description_alb     = "podcat security group for application load balancer"
sg_ingress_rules_cidr_alb = ["80,80,tcp,0.0.0.0/0,inbound_rules_sg_alb"]
podcat_sg_name_ec2            = "podcat-sow-sg_ec2"
podcat_sg_description_ec2     = "podcat security group have inbound access to two diff security groups"
#[data.aws_security_group.bastion_sg.name,module.security_group_alb.security_group_id]
# ask sai bro about how to pass these values.
#sg_ingress_rules_sgid_ec2= ["22,22,tcp,sg-0c629cf2ab1674d08,testing_sg_1","80,80,tcp,sg-0233f50174db3ecc8,testing_sg_2"]
sg_egress_rules_cidr = ["0,0,-1,0.0.0.0/0,outbound_rules_sg"]
default_tags = {
  Contact = "Yu Wei"
  Project = "Podcat"
}
instance_type = "t2.micro"
ami = "ami-0d5eff06f840b45e9"
route53record_name = "podcat_sow"
route53_zone_name = "bento-tools.org"
route53_record_type = "A"
evaluate_target_health = true
#target_zone_id = module.load_balancer.alb_zone_id
load_balancer_type = "application"
lb_name = "podcat-sow-alb"
internal = "false"
ip_address_type = "ipv4"
enable_deletion_protection = true
enable_http2 = true
alb_subnet = ["subnet-04b976a6953ed387e","subnet-3452df05"]
tg_name = "podcat-sow-tg"
tg_port = 80 # check with sai bro
tg_protocol = "HTTP"
target_type = "instance"
alb_port = 80
alb_protocol = "HTTP"
alb_ssl_policy = ""
tg_attachment_port = 80

