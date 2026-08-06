##########################################
# Redis Subnet Group
##########################################

resource "aws_elasticache_subnet_group" "this" {

  name = "${local.name}-redis-subnet-group"

  subnet_ids = var.private_subnet_ids

}

##########################################
# Redis Cluster
##########################################

resource "aws_elasticache_cluster" "this" {

  cluster_id = "${local.name}-redis"

  engine = "redis"

  engine_version = "7.1"

  node_type = var.node_type

  num_cache_nodes = 1

  parameter_group_name = "default.redis7"

  subnet_group_name = aws_elasticache_subnet_group.this.name

  security_group_ids = var.security_group_ids

  port = 6379

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-redis"
    }
  )

}