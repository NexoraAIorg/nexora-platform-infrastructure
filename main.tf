module "networking" {

  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment

  aws_region = var.aws_region

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_app_subnet_cidrs = var.private_app_subnet_cidrs

  private_db_subnet_cidrs = var.private_db_subnet_cidrs

  common_tags = local.common_tags

}

module "iam" {

  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment

  common_tags = local.common_tags

}

module "kms" {

  source = "./modules/kms"

  project_name = var.project_name
  environment  = var.environment

  common_tags = local.common_tags

}

module "secrets_manager" {

  source = "./modules/secrets-manager"

  project_name = var.project_name
  environment  = var.environment

  kms_key_id = module.kms.kms_key_id

  common_tags = local.common_tags

}

module "security" {

  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id

  common_tags = local.common_tags

}

module "s3" {

  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment

  kms_key_arn = module.kms.kms_key_arn

  common_tags = local.common_tags

}

module "ecr" {

  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  common_tags = local.common_tags

}

module "alb" {

  source = "./modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id

  public_subnet_ids = module.networking.public_subnet_ids

  common_tags = local.common_tags

}

module "route53" {

  source = "./modules/route53"

  project_name = var.project_name
  environment  = var.environment

  domain_name = var.domain_name

  alb_dns_name = module.alb.alb_dns_name

  alb_zone_id = module.alb.alb_zone_id

  common_tags = local.common_tags

}

module "eks" {

  source = "./modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_name = "${var.project_name}-${var.environment}"

  vpc_id = module.networking.vpc_id

  private_subnet_ids = module.networking.private_app_subnet_ids

  cluster_role_arn = module.iam.eks_cluster_role_arn

  node_role_arn = module.iam.eks_node_role_arn

  common_tags = local.common_tags

}

module "rds" {

  source = "./modules/rds"

  project_name = var.project_name
  environment  = var.environment

  private_subnet_ids = module.networking.private_db_subnet_ids

  security_group_ids = [
    module.security.database_security_group_id
  ]

  db_username = var.db_username

  db_password = var.db_password

  common_tags = local.common_tags

}

module "redis" {

  source = "./modules/redis"

  project_name = var.project_name
  environment  = var.environment

  private_subnet_ids = module.networking.private_db_subnet_ids

  security_group_ids = [
    module.security.redis_security_group_id
  ]

  common_tags = local.common_tags

}

module "opensearch" {

  source = "./modules/opensearch"

  project_name = var.project_name
  environment  = var.environment

  private_subnet_ids = module.networking.private_app_subnet_ids

  security_group_ids = [
    module.security.opensearch_security_group_id
  ]

  common_tags = local.common_tags

}

module "monitoring" {

  source = "./modules/monitoring"

  project_name = var.project_name
  environment  = var.environment

  common_tags = local.common_tags

}

