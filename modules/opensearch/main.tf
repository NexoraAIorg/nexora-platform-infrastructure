resource "aws_opensearch_domain" "this" {

  domain_name = "${local.name}-search"

  engine_version = "OpenSearch_2.17"

  cluster_config {

    instance_type = var.instance_type

    instance_count = 1

  }

  ebs_options {

    ebs_enabled = true

    volume_size = 20

    volume_type = "gp3"

  }

  vpc_options {

    subnet_ids = [
      var.private_subnet_ids[0]
    ]

    security_group_ids = var.security_group_ids

  }

  encrypt_at_rest {

    enabled = true

  }

  node_to_node_encryption {

    enabled = true

  }

  domain_endpoint_options {

    enforce_https = true

  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-opensearch"
    }
  )

}