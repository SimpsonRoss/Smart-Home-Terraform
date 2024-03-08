output "public_alb_dns_name" {
  value = aws_lb.public_alb.dns_name
}

output "private_alb_dns_name" {
  value = aws_lb.private_alb.dns_name
}

output "lighting_tg_arn" {
  value = aws_lb_target_group.service_tg["lighting"].arn
}

output "heating_tg_arn" {
  value = aws_lb_target_group.service_tg["heating"].arn
}

output "status_tg_arn" {
  value = aws_lb_target_group.service_tg["status"].arn
}

output "auth_tg_arn" {
  value = aws_lb_target_group.service_tg["auth"].arn
}