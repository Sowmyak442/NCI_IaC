variable "profile" {}
variable "aws_region" {}

variable "default_tags" {
  type = map(string)
}
#For CIDR
variable "sg_ingress_rules_cidr" {
  description = "Ingress CIDR rules in the format '{from port},{to port},{protocol},{cidr blocks},{description}'"
  type = list(string)
  default = []
}
variable "sg_egress_rules_cidr" {
  description = "Ingress CIDR rules in the format '{from port},{to port},{protocol},{cidr blocks},{description}'"
  type = list(string)
  default = []
}
variable "sg_ingress_rules_sgid" {
  description = "ingress Security group ID in the format '{from port},{to port},{protocol},{security group ids},{description}'"
  type = list(string)
  default = []
}
variable "sg_egress_rules_sgid" {
  description = "egress Security group ID in the format '{from port},{to port},{protocol},{security group ids},{description}'"
  type = list(string)
  default = []
}

variable "sg_ingress_rules_prefixid" {
  description = "ingress Security group ID in the format '{from port},{to port},{protocol},{Prefix list ids},{description}'"
  type = list(string)
  default = []
}
variable "sg_egress_rules_prefixid" {
  description = "egress Security group ID in the format '{from port},{to port},{protocol},{Prefix list ids},{description}'"
  type = list(string)
  default = []
}
variable "sg_ingress_rules_self" {
  description = "egress Security group ID in the format '{from port},{to port},{protocol},{self},{description}'"
  type = list(string)
  default = []
}
variable "sg_egress_rules_self" {
  description = "egress Security group ID in the format '{from port},{to port},{protocol},{self},{description}'"
  type = list(string)
  default = []
}

variable "instance_type" {
  type = string
  default = "t3.small"
}
variable "ami" {
  default = "ami-0affd4508a5d2481b"
  type = string
}


#Security group for EC2
variable "podcat_sg_name_ec2" {}
variable "podcat_sg_description_ec2" {}
variable "sg_ingress_rules_sgid_ec2" {
  description = "ingress Security group ID in the format '{from port},{to port},{protocol},{security group ids},{description}'"
  type = list(string)
  default = []
}

#Security group for ALB
variable "podcat_sg_name_alb" {}
variable "podcat_sg_description_alb" {}
variable "sg_ingress_rules_cidr_alb" {
  description = "Ingress CIDR rules in the format '{from port},{to port},{protocol},{cidr blocks},{description}'"
  type = list(string)
  default = []
}

variable "alb_subnet" {
  type = list(string)
  default = []
}

variable "bastionhost_sgid" {}

#Route 53 related variables
variable "route53_zone_name" {}
variable "route53record_name" {}
variable "route53_record_type" {}
variable "evaluate_target_health" {
  type = bool
}

variable "load_balancer_type" {}
variable "lb_name" {}
variable "internal" {
  type = bool
}
variable "ip_address_type" {}

variable "enable_deletion_protection" {
  type = bool
}
variable "enable_http2" {
  type = bool
}
variable "tg_name" {}
variable "tg_port" {}
variable "tg_protocol" {}
variable "target_type" {}
variable "alb_port" {
  type = number
}
variable "alb_protocol" {}
variable "alb_ssl_policy" {}

variable "tg_attachment_port" {
  type = number
}