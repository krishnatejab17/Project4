variable "app_name" {
  description = "The name of the application."
  type        = string
}
variable "app_environment" {
  description = "The environment of the application (e.g., dev, staging, prod)."
  type        = string
}

variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the ECR repository."
  type        = string
  default     = "MUTABLE"
}
variable "encryption_type" {
  description = "The encryption type for the ECR repository."
  type        = string
  default     = "AES256"
}

variable "lifecycle_policy" {
  description = "The lifecycle policy for the ECR repository in JSON format."
  type        = string
}

