variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "security_group_ids" {
  description = "Security group ID list"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID to be used for the instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  default     = "t2.micro"
}

# variable "bastion_security_group_id" {
#   description = "Bastion security group ID"
#   type       = string
# }