output "security_group_ids" {
  description = "Security group ID list"
  value = [aws_security_group.allow_http.id, aws_security_group.allow_https.id, aws_security_group.allow_ssh.id]
}

# output "bastion_security_group_id" {
#   description = "Bastion security group ID"
#   value = aws_security_group.bastion_host_sg.id
# }