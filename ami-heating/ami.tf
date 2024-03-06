resource "aws_ami_from_instance" "heating_ami" {
  name               = "heating-ami-${formatdate("YYYY-MM-DD", timestamp())}"
  source_instance_id = "i-0e5bd4724626a6815"
  snapshot_without_reboot = true
  
  tags = {
    "Name" = "Heating Service AMI"
    "Created" = timestamp()
  }
}