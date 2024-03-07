# Public facing application load balancer

resource "aws_lb" "public_alb" {
  name               = "Main-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_alb_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false
}

# ------------------------------------------------------------

# Private, Internal facing application load balancer

resource "aws_lb" "private_alb" {
  name               = "Main-private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_alb_security_group_id]
  subnets            = var.private_subnet_ids

  enable_deletion_protection = false
}

# ------------------------------------------------------------

# Public facing listener and default action

resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}

# Public facing listener rules

resource "aws_lb_listener_rule" "public_rule" {
  for_each = var.services

  listener_arn = aws_lb_listener.public_listener.arn
  priority     = 100 + length(each.key)
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service_tg[each.key].arn
  }

  condition {
    path_pattern {
      values = ["/${each.key}*"]
    }
  }
}

# ------------------------------------------------------------

# Private Listener on the Private ALB with default action

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}

# ------------------------------------------------------------

# Target groups for the each service

resource "aws_lb_target_group" "service_tg" {
  for_each = var.services

  name     = "Main-${each.key}-tg"
  port     = each.value.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = each.value.health_path
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

# ------------------------------------------------------------

# Target group associations

resource "aws_lb_target_group_attachment" "lighting_attachment" {
  target_group_arn = aws_lb_target_group.service_tg["lighting"].arn
  target_id        = var.lighting_instance_id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "heating_attachment" {
  target_group_arn = aws_lb_target_group.service_tg["heating"].arn
  target_id        = var.heating_instance_id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "status_attachment" {
  target_group_arn = aws_lb_target_group.service_tg["status"].arn
  target_id        = var.status_instance_id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "auth_attachment" {
  target_group_arn = aws_lb_target_group.service_tg["auth"].arn
  target_id        = var.auth_instance_id
  port             = 3000
}
