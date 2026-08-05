output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_port" {
  description = "Database Port"
  value       = aws_db_instance.this.port
}

output "db_arn" {
  description = "RDS ARN"
  value       = aws_db_instance.this.arn
}