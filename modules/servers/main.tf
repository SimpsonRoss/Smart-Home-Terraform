# Lighting EC2 instance on public subnet

resource "aws_instance" "lighting"  {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 0)
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "Lighting"
  }
}

# ------------------------------------------------------------

# Heating EC2 instance on public subnet

resource "aws_instance" "heating"  {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 1)
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "Heating"
  }
}

# ------------------------------------------------------------

# Status EC2 instance on public subnet

resource "aws_instance" "status"  {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 2)
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "Status"
  }
}

# ------------------------------------------------------------

# Auth EC2 instance on private subnet

resource "aws_instance" "auth" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Auth"
  }
}

# ------------------------------------------------------------
