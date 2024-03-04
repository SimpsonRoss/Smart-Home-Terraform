output "security_group_ids" {
  description = "Security group ID list"
  value = [aws_security_group.allow_http.id, aws_security_group.allow_https.id, aws_security_group.allow_ssh.id]
}
