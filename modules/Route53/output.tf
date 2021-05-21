output "route53_name" {
  value = aws_route53_record.route53_rec.name
}

output "route53_fqdn" {
  value = aws_route53_record.route53_rec.fqdn
}