output "alb_dnsname"{
  value = aws_lb.application_loadbalancer.dns_name
}

output "alb_zone_id" {
  value = aws_lb.application_loadbalancer.zone_id
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.main_tg.arn
}

variable "ec2_target_id" {
  default = ""
}