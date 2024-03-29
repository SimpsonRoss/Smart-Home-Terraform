data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}


# Lighting EC2 instance on public subnet

resource "aws_instance" "lighting"  {
  ami = "ami-0ee9d687eab0ed726"
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 0)
  vpc_security_group_ids = var.security_group_ids
  key_name = "MyKeyPair4"
  tags = {
    Name = "Lighting"
  }
}

# ------------------------------------------------------------

# Heating EC2 instance on public subnet

resource "aws_instance" "heating"  {
  ami = "ami-082d40138a106ff58"
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 1)
  vpc_security_group_ids = var.security_group_ids
  key_name = "MyKeyPair4"
  tags = {
    Name = "Heating"
  }
}

# ------------------------------------------------------------

# Status EC2 instance on public subnet

resource "aws_instance" "status"  {
  ami = "ami-0981bccc7ae95d796"
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 2)
  vpc_security_group_ids = var.security_group_ids
  key_name = "MyKeyPair4"
  tags = {
    Name = "Status"
  }
}

# ------------------------------------------------------------

# Auth EC2 instance on private subnet

resource "aws_instance" "auth" {
  # ami = "ami-0b2a4711206951c46" commenting out until I make an AMI utilising dynamodb
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name = "MyKeyPair4"
  tags = {
    Name = "Auth"
  }
}

# ------------------------------------------------------------