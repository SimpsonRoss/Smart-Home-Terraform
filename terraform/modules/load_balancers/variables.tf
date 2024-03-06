variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the public load balancer"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the internal load balancer"
  type        = list(string)
}

variable "services" {
  description = "A map of service names to their settings including port and health check path"
  type = map(object({
    port          = number
    health_path   = string
  }))
}

variable "public_alb_security_group_id" {
  description = "The security group ID for the public load balancer"
  type        = string
}

variable "private_alb_security_group_id" {
  description = "The security group ID for the internal load balancer"
  type        = string
}

variable "lighting_instance_id" {
  description = "Lighting instance ID"
  type = string
}

variable "heating_instance_id" {
  description = "Heating instance ID"
  type = string
}

variable "status_instance_id" {
  description = "Status instance ID"
  type = string
}

variable "auth_instance_id" {
  description = "Auth instance ID"
  type = string
}