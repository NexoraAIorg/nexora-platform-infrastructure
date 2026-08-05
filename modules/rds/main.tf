#############################################
# DB Subnet Group
#############################################

resource "aws_db_subnet_group" "this" {

  name = "${local.name_prefix}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-db-subnet-group"
    }
  )
}

#############################################
# PostgreSQL RDS Instance
#############################################

resource "aws_db_instance" "this" {

  identifier = "${local.name_prefix}-postgres"

  engine         = "postgres"
  engine_version = "17"

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = var.database_security_group_ids

  multi_az = var.multi_az

  publicly_accessible = false

  storage_encrypted = true

  backup_retention_period = 7

  deletion_protection = false

  skip_final_snapshot = true

  apply_immediately = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-postgres"
    }
  )
}