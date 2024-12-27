provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "darpo-prod"
  vpc_cidr = "10.1.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnet_cidrs  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
  environment = var.environment
  single_nat_gateway = false  # High availability for production
}

module "eks" {
  source = "../../modules/eks"

  cluster_name    = "darpo-prod"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  environment     = var.environment
  desired_size    = 3
  min_size        = 3
  max_size        = 10
  instance_types  = ["t3.xlarge"]
}

module "rds" {
  source = "../../modules/rds"

  depends_on = [module.vpc, aws_security_group.rds]

  environment = var.environment
  instance_class = "db.t3.large"
  allocated_storage = 100
  max_allocated_storage = 1000
  db_name = "darpo"
  db_username = var.db_username
  db_subnet_group_name = module.vpc.database_subnet_group
  vpc_security_group_ids = [aws_security_group.rds.id]
  multi_az = true  # High availability for production
}