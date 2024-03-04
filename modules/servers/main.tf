resource "aws_instance" "lighting"  {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 0)
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "Lighting"
  }
}

resource "aws_instance" "heating"  {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 1)
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "Heating"
  }
}

resource "aws_instance" "status"  {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 2)
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "Status"
  }
}

resource "aws_instance" "auth" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Auth"
  }
}