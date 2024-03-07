resource "aws_ami_from_instance" "status_ami" {
  name               = "status-ami-${formatdate("YYYY-MM-DD", timestamp())}"
  source_instance_id = "i-0509492d4809a724d"
  snapshot_without_reboot = true
  
  tags = {
    "Name" = "Status Service AMI"
    "Created" = timestamp()
  }
}