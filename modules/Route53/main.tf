resource "aws_route53_record" "route53_rec" {
  zone_id = var.zone_id
  name    = var.name
  type    = var.type

  alias {
    evaluate_target_health = var.evaluate_target_health
    name = var.target_name
    zone_id = var.target_zone_id
  }
}