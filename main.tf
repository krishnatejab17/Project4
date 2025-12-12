terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.region
}

module "alb" {
  source          = "./modules/alb"
  app_name        = var.app_name
  app_environment = var.app_environment
  }
module "ecr" {
  source = "./modules/ecr"

  repository_name      = var.repository_name
  app_environment      = var.app_environment
  image_tag_mutability = var.image_tag_mutability
  encryption_type      = var.encryption_type
  lifecycle_policy     = var.lifecycle_policy
}

module "ecs" {
  source          = "./modules/ecs"
  app_name        = var.app_name
  app_environment = var.app_environment
  image_tag       = var.image_tag
}

module "iam" {
  source = "./modules/iam"

  github_actions_role_name = var.github_actions_role_name
}

module "networking" {
  source          = "./modules/networking"
  app_name        = var.app_name
  app_environment = var.app_environment
  public_subnets  = var.public_subnets
  availability_zones = var.availability_zones
}

module "sg" {
  source          = "./modules/sg"
  app_name        = var.app_name
  app_environment = var.app_environment
}

module "route53" {
  source = "./modules/route53"
}   

