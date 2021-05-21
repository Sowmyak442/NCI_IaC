variable "sg_name" {}
variable "sg_description" {}
variable "vpc_id" {}
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