##########################################
# EKS Cluster
##########################################

resource "aws_eks_cluster" "this" {

  name = var.cluster_name

  version = var.cluster_version

  role_arn = var.cluster_role_arn

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {

    subnet_ids = var.private_subnet_ids

    endpoint_private_access = true

    endpoint_public_access = true

  }

  access_config {

    authentication_mode = "API_AND_CONFIG_MAP"

    bootstrap_cluster_creator_admin_permissions = true

  }

  tags = merge(
    local.tags,
    {
      Name = var.cluster_name
    }
  )

}

##########################################
# Managed Node Group
##########################################

resource "aws_eks_node_group" "default" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${local.name}-default"

  node_role_arn = var.node_role_arn

  subnet_ids = var.private_subnet_ids

  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  instance_types = var.instance_types

  disk_size = var.disk_size

  scaling_config {

    desired_size = var.desired_size

    min_size = var.min_size

    max_size = var.max_size

  }

  update_config {

    max_unavailable = 1

  }

  labels = {

    workload = "general"

    environment = var.environment

  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-node-group"
    }
  )

  depends_on = [
    aws_eks_cluster.this
  ]

}

##########################################
# CoreDNS
##########################################

resource "aws_eks_addon" "coredns" {

  cluster_name = aws_eks_cluster.this.name

  addon_name = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"

}

##########################################
# kube-proxy
##########################################

resource "aws_eks_addon" "kube_proxy" {

  cluster_name = aws_eks_cluster.this.name

  addon_name = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"

}

##########################################
# VPC CNI
##########################################

resource "aws_eks_addon" "vpc_cni" {

  cluster_name = aws_eks_cluster.this.name

  addon_name = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"

}

##########################################
# EBS CSI Driver
##########################################

resource "aws_eks_addon" "ebs_csi" {

  cluster_name = aws_eks_cluster.this.name

  addon_name = "aws-ebs-csi-driver"

  resolve_conflicts_on_create = "OVERWRITE"

}