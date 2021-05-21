resource "aws_lb" "application_loadbalancer" {
  load_balancer_type         = var.load_balancer_type
  name                       = var.lb_name
  internal                   = var.internal
  ip_address_type            = var.ip_address_type
  security_groups            = var.security_groups
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
  enable_http2               = var.enable_http2
  tags = merge(
  var.default_tags,
  {
    name = format("%s", var.lb_name)
  }
  )

}

resource "aws_lb_target_group" "main_tg" {
  name             = var.tg_name
  vpc_id           = var.vpc_id
  port             = var.tg_port
  protocol         = var.tg_protocol
  target_type      = var.target_type
  tags = merge(
  var.default_tags,
  {
    name = format("%s", var.tg_name)
  }
  )
}

resource "aws_alb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_loadbalancer.arn
  port = var.alb_port
  protocol = var.alb_protocol
  ssl_policy = var.alb_ssl_policy
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main_tg.arn
  }
}

resource "aws_alb_listener" "https_listener" {
  load_balancer_arn = aws_lb.application_loadbalancer.arn
  port = var.alb_port
  protocol = var.alb_protocol
  ssl_policy = var.alb_ssl_policy
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main_tg.arn
  }
}


resource "aws_lb_target_group_attachment" "ec2_instance" {
  target_group_arn = aws_lb_target_group.main_tg.arn
  target_id        = var.tg_attachment_ec2_target_id
  port             = var.tg_attachment_port
}