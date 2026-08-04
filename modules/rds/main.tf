##########################################
# DB Subnet Group
##########################################

resource "aws_db_subnet_group" "this" {

  name = "${local.name}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-db-subnet-group"
    }
  )
}

##########################################
# PostgreSQL
##########################################

resource "aws_db_instance" "this" {

  identifier = "${local.name}-postgres"

  engine = "postgres"

  engine_version = "16"

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  storage_encrypted = true

  publicly_accessible = false

  multi_az = false

  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = var.security_group_ids

  deletion_protection = false

  backup_retention_period = 7

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-postgres"
    }
  )

}