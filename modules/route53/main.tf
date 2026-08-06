resource "aws_route53_zone" "this" {

  name = var.domain_name

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-hosted-zone"
    }
  )
}

resource "aws_route53_record" "alb" {

  zone_id = aws_route53_zone.this.zone_id

  name = "app.${var.domain_name}"

  type = "A"

  alias {

    name = var.alb_dns_name

    zone_id = var.alb_zone_id

    evaluate_target_health = true

  }

}