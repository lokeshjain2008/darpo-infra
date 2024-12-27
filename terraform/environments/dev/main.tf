provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "darpo-dev"
  vpc_cidr = "10.0.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b"]
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]
  environment = var.environment
  single_nat_gateway = true
}

module "eks" {
  source = "../../modules/eks"

  cluster_name    = "darpo-dev"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  environment     = var.environment
  desired_size    = 2
  min_size        = 1
  max_size        = 4
  instance_types  = ["t3.medium"]
}

module "rds" {
  source = "../../modules/rds"

  depends_on = [module.vpc, aws_security_group.rds]

  environment = var.environment
  instance_class = "db.t3.small"
  allocated_storage = 20
  max_allocated_storage = 100
  db_name = "darpo"
  db_username = var.db_username
  db_subnet_group_name = module.vpc.database_subnet_group
  vpc_security_group_ids = [aws_security_group.rds.id]
  multi_az = false
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name = "darpo-api"
  environment     = var.environment
}