resource "aws_ami_from_instance" "lighting_ami" {
  name               = "lighting-ami-${formatdate("YYYY-MM-DD", timestamp())}"
  source_instance_id = "i-04a97fb411d9376ca"
  snapshot_without_reboot = true
  
  tags = {
    "Name" = "Lighting Service AMI"
    "Created" = timestamp()
  }
}