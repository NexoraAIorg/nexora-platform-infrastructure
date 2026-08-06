output "hosted_zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "hosted_zone_name_servers" {
  value = aws_route53_zone.this.name_servers
}

output "application_fqdn" {
  value = aws_route53_record.alb.fqdn
}