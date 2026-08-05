variable "project_name" {
  description = "Name of the project used for resource naming."
  type        = string

  validation {
    condition     = length(var.project_name) > 2
    error_message = "Project name must contain at least 3 characters."
  }
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be one of: dev, stage, prod."
  }
}

variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Invalid VPC CIDR block."
  }
}

variable "availability_zones" {
  description = "List of Availability Zones."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones are required."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "Number of public subnet CIDRs must match the number of Availability Zones."
  }
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets."
  type        = list(string)

  validation {
    condition     = length(var.private_app_subnet_cidrs) == length(var.availability_zones)
    error_message = "Number of private application subnet CIDRs must match the number of Availability Zones."
  }
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets."
  type        = list(string)

  validation {
    condition     = length(var.private_db_subnet_cidrs) == length(var.availability_zones)
    error_message = "Number of private database subnet CIDRs must match the number of Availability Zones."
  }
}

variable "enable_nat_gateway" {
  description = "Whether to provision a NAT Gateway."
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}