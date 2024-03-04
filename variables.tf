variable "region" {
  description = "The region in which the VPC will be created"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones in which the VPC will be created"
  type        = list(string)
}

variable "my_ip" {
  description = "My IP address"
  type        = string
}
