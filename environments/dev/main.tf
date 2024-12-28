provider "aws" {
  region = var.aws_region
}

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
  }
}

locals {
  common_tags = {
    Project     = "darpo"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name             = "darpo-dev"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["ap-south-1a", "ap-south-1b"]
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnet_cidrs = ["10.0.201.0/24", "10.0.202.0/24"]
  environment         = var.environment
  single_nat_gateway  = true  # Cost optimization for dev
  tags                = local.common_tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name    = "darpo-dev"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  environment     = var.environment

  min_size        = 1
  max_size        = 4
  desired_size    = 2
  instance_types  = ["t3.medium"]

  github_actions_role_external_id = var.github_actions_external_id

  tags = local.common_tags
}

# Create aws-auth ConfigMap after cluster is fully ready
resource "null_resource" "apply_aws_auth_cm" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = <<-EOT
      aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_id}
      kubectl apply -f - <<EOF
      apiVersion: v1
      kind: ConfigMap
      metadata:
        name: aws-auth
        namespace: kube-system
      data:
        mapRoles: |
          - rolearn: ${module.eks.github_actions_role_arn}
            username: github-actions
            groups:
              - system:masters
      EOF
    EOT
  }
}