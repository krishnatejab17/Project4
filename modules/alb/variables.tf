
variable "app_name" {
  description = "The name of the application"
  type        = string
}   

variable "app_environment" {
  description = "The environment of the application (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}   