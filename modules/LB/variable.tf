#variables for load balancer
variable "load_balancer_type" {
  type = string
  default = "application"
}
variable "internal" {
  default = "true"
  type = bool
}
variable "security_groups" {
  type = list(string)
}
variable "subnets" {
  type = list(string)
  default = []
}
variable "enable_deletion_protection" {
  type = bool
  default = true
}
variable "enable_http2" {
  type = bool
  default = true
}
variable "ip_address_type" {
  default = ""
}

variable "default_tags" {
  type = map(string)
}

variable "lb_name" {
  default = ""
}

#variables for target group
variable "tg_name" {
  description = "forces new resource,if not given terraform will give some random unique name"
}
variable "vpc_id" {}
variable "tg_port" {
  type = number
}
variable "tg_protocol" {}
variable "target_type" {}


#variables for alb listener
variable "alb_port" {
  type = number
}
variable "alb_protocol" {}
variable "alb_ssl_policy" {}
variable "tg_attachment_ec2_target_id" {}
variable "tg_attachment_port" {
  type = number
}