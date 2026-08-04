output "redis_endpoint" {
  value = aws_elasticache_cluster.this.cache_nodes[0].address
}

output "redis_port" {
  value = aws_elasticache_cluster.this.port
}

output "redis_cluster_id" {
  value = aws_elasticache_cluster.this.cluster_id
}