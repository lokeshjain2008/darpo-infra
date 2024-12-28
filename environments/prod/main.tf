provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "darpo-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "darpo-terraform-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

locals {
  common_tags = {
    Project     = "darpo"
    Environment = "prod"
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name             = "darpo-prod"
  vpc_cidr             = "10.1.0.0/16"
  availability_zones   = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnet_cidrs  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
  database_subnet_cidrs = ["10.1.201.0/24", "10.1.202.0/24", "10.1.203.0/24"]
  environment         = "prod"
  single_nat_gateway  = false  # High availability for prod
  tags                = local.common_tags
}