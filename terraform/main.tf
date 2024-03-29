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

module "dynamodb_auth" {
  source = "./modules/database"
  table_name = "AuthUsers"
  hash_key = "username"
  hash_key_type = "S"
}

module "ec2_instances" {
  source = "./modules/servers"
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_id = module.vpc.private_subnet_ids[0]
  security_group_ids = module.security_groups.security_group_ids
  ami_id = var.ami_id
}

module "load_balancers" {
  source = "./modules/load_balancers"
  public_alb_security_group_id = module.security_groups.security_group_ids[0]
  private_alb_security_group_id = module.security_groups.security_group_ids[0]
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  services           = {
    lighting = {
      port        = 3000
      health_path = "/api/lights/health"
    },
    heating = {
      port        = 3000
      health_path = "/api/heating/health"
    },
    status = {
      port        = 3000
      health_path = "/api/status/health"
    },
    auth = {
      port        = 3000
      health_path = "/api/auth"
    }
  }
  lighting_instance_id           = module.ec2_instances.lighting_instance_id
  heating_instance_id            = module.ec2_instances.heating_instance_id
  status_instance_id             = module.ec2_instances.status_instance_id
  auth_instance_id               = module.ec2_instances.auth_instance_id
}

module "autoscaling" {
  source = "./modules/auto_scaling"
  security_group_ids = module.security_groups.security_group_ids
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  lighting_tg_arn = module.load_balancers.lighting_tg_arn
  heating_tg_arn = module.load_balancers.heating_tg_arn
  status_tg_arn = module.load_balancers.status_tg_arn
  auth_tg_arn = module.load_balancers.auth_tg_arn
}
