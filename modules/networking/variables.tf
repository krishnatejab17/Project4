variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "app_environment" {
  description = "The environment of the application (e.g., dev, staging, prod)."
  type        = string
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones for the subnets."
  type        = list(string)
}
