module "vpc" {
  source = "./modules/vpc"
  region = var.region
  cidr_block = var.cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  my_ip = var.my_ip
}

module "dynamodb_lighting" {
  source = "./modules/database"
  table_name = "Lighting"
  hash_key = "id"
  hash_key_type = "N"
}

module "dynamodb_heating" {
  source = "./modules/database"
  table_name = "Heating"
  hash_key = "id"
  hash_key_type = "N"
}

module "ec2_instances" {
  source = "./modules/servers"
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_id = module.vpc.private_subnet_ids[0]
  security_group_ids = module.security_groups.security_group_ids
  ami_id = var.ami_id
}