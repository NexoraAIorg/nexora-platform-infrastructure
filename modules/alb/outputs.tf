output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "security_group_id" {
  value = aws_security_group.alb.id
}

output "alb_zone_id" {
  description = "Hosted Zone ID of the ALB"
  value       = aws_lb.this.zone_id
}
