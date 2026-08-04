resource "aws_secretsmanager_secret" "application" {

  name        = "${local.name}-application-secret"

  description = "Application secrets"

  kms_key_id = var.kms_key_id

  recovery_window_in_days = 7

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-application-secret"
    }
  )
}

resource "aws_secretsmanager_secret_version" "application" {

  secret_id = aws_secretsmanager_secret.application.id

  secret_string = jsonencode({
    username = "change-me"
    password = "change-me"
    api_key  = "change-me"
  })
}