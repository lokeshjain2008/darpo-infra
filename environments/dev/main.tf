# Provider configuration
provider "aws" {
  region = var.aws_region
}

# Remote state configuration
terraform {
  backend "s3" {
    bucket         = "darpo-terraform-state"
    key            = "dev/terraform.tfstate"
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

# Common tags for all resources
locals {
  common_tags = {
    Project     = "darpo"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  vpc_name             = "darpo-dev"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["ap-south-1a", "ap-south-1b"]
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnet_cidrs = ["10.0.201.0/24", "10.0.202.0/24"]
  environment         = "dev"
  single_nat_gateway  = true  # Cost optimization for dev
  tags                = local.common_tags
}