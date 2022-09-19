terraform {
  required_version = ">=1.2.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    organization = var.organization

    workspaces {
      name = va.workspace
    }
  }
}

module "provider" {
  source          = "../../modules/provider"
  access_key_temp = var.AWS_ACCESS_KEY
  secret_key_temp = var.AWS_SECRET_KEY
}

module "s3" {
  source = "../../modules/s3"
}

module "vpc" {
  source = "../../modules/vpc"
}
