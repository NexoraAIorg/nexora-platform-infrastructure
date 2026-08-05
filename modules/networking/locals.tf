locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "networking"
    }
  )

  availability_zone_map = {
    for index, az in var.availability_zones :
    az => {
      public_subnet_cidr      = var.public_subnet_cidrs[index]
      private_app_subnet      = var.private_app_subnet_cidrs[index]
      private_database_subnet = var.private_db_subnet_cidrs[index]
    }
  }
}