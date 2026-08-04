resource "aws_security_group" "alb" {

  name        = "${local.name}-alb-sg"

  description = "Application Load Balancer Security Group"

  vpc_id = var.vpc_id

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-alb-sg"
    }
  )
}

resource "aws_lb" "this" {

  name = "${local.name}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = var.public_subnet_ids

  tags = merge(
    local.tags,
    {
      Name = "${local.name}-alb"
    }
  )
}

resource "aws_lb_target_group" "this" {

  name = "${local.name}-tg"

  port = 80

  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "ip"

  health_check {

    path = "/"

    protocol = "HTTP"

  }

}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn

  }

}