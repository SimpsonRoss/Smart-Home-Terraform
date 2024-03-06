data "aws_ami" "ubuntu" {
  // Gets the latest ubuntu AMI ID
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's ID - creators of the Ubuntu AMI
}


# Lighting EC2 instance on public subnet

resource "aws_instance" "lighting"  {
  # ami = var.ami_id
  ami = "ami-0ee9d687eab0ed726"
  instance_type = var.instance_type
  subnet_id = element(var.public_subnet_ids, 0)
  vpc_security_group_ids = var.security_group_ids
  key_name = "MyKeyPair4"

  # user_data = <<-EOF
  #           #!/bin/bash
  #           curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  #           export NVM_DIR="$HOME/.nvm"
  #           [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  #           [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  #           nvm install --lts
  #           npm install pm2@latest -g
  #           cd ce-project-lights
  #           npm install
  #           touch .env
  #           pm2 start npm -- run start
  #           EOF

  tags = {
    Name = "Lighting"
  }

}

# ------------------------------------------------------------

# Heating EC2 instance on public subnet

resource "aws_instance" "heating"  {
  # ami = var.ami_id
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
  # ami = var.ami_id
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
  ami = "ami-0b2a4711206951c46"
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name = "MyKeyPair4"
  tags = {
    Name = "Auth"
  }
}

# ------------------------------------------------------------

# # Bastion Host

# resource "aws_instance" "bastion_host" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t2.micro"
#   subnet_id              = element(var.public_subnet_ids, 0) 
#   vpc_security_group_ids = [var.bastion_security_group_id]
#   key_name               = "MyKeyPair4"
#   tags = {
#     Name = "BastionHost"
#   }
# }
