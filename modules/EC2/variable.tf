variable "ami" {}
variable "instance_type" {}
variable "default_tags" {
  type = map(string)
}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "subnet_id" {
  default = ""
}
