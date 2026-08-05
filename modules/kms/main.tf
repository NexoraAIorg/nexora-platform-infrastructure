resource "aws_kms_key" "this" {

  description = "KMS Key for Nexora Platform"

  deletion_window_in_days = var.deletion_window_in_days

  enable_key_rotation = true

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-kms-key"
    }
  )
}

resource "aws_kms_alias" "this" {

  name = "alias/${local.name}"

  target_key_id = aws_kms_key.this.key_id

}