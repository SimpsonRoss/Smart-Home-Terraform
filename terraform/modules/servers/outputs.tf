output "lighting_instance_id" {
  description = "Lighting instance ID"
  value = aws_instance.lighting.id
}

output "heating_instance_id" {
  description = "Heating instance ID"
  value = aws_instance.heating.id
}

output "status_instance_id" {
  description = "Status instance ID"
  value = aws_instance.status.id
}

output "auth_instance_id" {
  description = "Auth instance ID"
  value = aws_instance.auth.id
}