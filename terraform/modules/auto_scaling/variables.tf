variable "security_group_ids" {
  description = "Security group ID list"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "lighting_tg_arn" {
  type        = string
}

variable "heating_tg_arn" {
  type        = string
}

variable "status_tg_arn" {
  type        = string
}

variable "auth_tg_arn" {
  type        = string
}

  variable "min_size"  {
    type = number
    default = 1
  }     

  variable "max_size" {
    type = number
    default = 3
  }     

  variable "desired_capacity" {
    type = number
    default = 2
  }