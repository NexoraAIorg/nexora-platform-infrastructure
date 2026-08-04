output "domain_endpoint" {
  value = aws_opensearch_domain.this.endpoint
}

output "domain_arn" {
  value = aws_opensearch_domain.this.arn
}

output "dashboard_endpoint" {
  value = aws_opensearch_domain.this.dashboard_endpoint
}