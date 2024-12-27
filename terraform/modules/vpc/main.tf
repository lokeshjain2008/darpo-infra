module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                 = var.availability_zones
  private_subnets     = var.private_subnet_cidrs
  public_subnets      = var.public_subnet_cidrs
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24"]

  create_database_subnet_group = true
  create_database_subnet_route_table = true

  enable_nat_gateway = true
  single_nat_gateway = var.single_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = var.environment
    Project     = "darpo"
    Terraform   = "true"
    Name        = var.vpc_name
  }
}