provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "darpo-dev"
  vpc_cidr = "10.0.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  environment = "dev"
}

module "eks" {
  source = "../../modules/eks"

  cluster_name    = "darpo-dev"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  environment     = "dev"
  desired_size    = 2
  min_size        = 1
  max_size        = 4
  instance_types  = ["t3.large"]
}

module "rds" {
  source = "../../modules/rds"

  environment = "dev"
  instance_class = "db.t3.large"
  allocated_storage = 20
  max_allocated_storage = 100
  db_name = "darpo"
  db_username = var.db_username
  db_subnet_group_name = module.vpc.database_subnet_group
  vpc_security_group_ids = [aws_security_group.rds.id]
}