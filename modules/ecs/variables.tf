variable "app_name" {
  description = "The name of the application."
  type        = string
}   

variable "app_environment" {
  description = "The environment of the application (e.g., dev, staging, prod)."
  type        = string
}

variable "image_tag" {
  description = "The tag of the Docker image to use for the ECS task."
  type        = string
}
