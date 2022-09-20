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

module "iam" {
  source = "../../modules/iam"
}

module "ec2" {
  source = "../../modules/ec2"

  iam_instance_profile = module.iam.iam_instance_profile
  public_subnet_id     = module.vpc.pub_subnet_id
}
