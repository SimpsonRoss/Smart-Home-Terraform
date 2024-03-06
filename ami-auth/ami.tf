resource "aws_ami_from_instance" "auth_ami" {
  name               = "auth-ami-${formatdate("YYYY-MM-DD", timestamp())}"
  source_instance_id = "i-0cb961a6736cade50"
  snapshot_without_reboot = true
  
  tags = {
    "Name" = "Auth Service AMI"
    "Created" = timestamp()
  }
}