output "eks_security_group_id" {
  value = aws_security_group.eks.id
}

output "database_security_group_id" {
  value = aws_security_group.database.id
}

output "redis_security_group_id" {
  value = aws_security_group.redis.id
}

output "opensearch_security_group_id" {
  value = aws_security_group.opensearch.id
}