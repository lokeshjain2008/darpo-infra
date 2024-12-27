# Infrastructure Outputs

# ECR outputs
output "ecr_repository_url" {
  description = "ECR Repository URL"
  value       = module.ecr.repository_url
}

# EKS outputs
output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_id
}

# RDS outputs
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_database_name" {
  description = "RDS database name"
  value       = module.rds.db_instance_name
}

# Debug outputs (for verification and troubleshooting)
output "debug_vpc_id" {
  description = "VPC ID from VPC module"
  value       = module.vpc.vpc_id
}

output "debug_sg_vpc_id" {
  description = "VPC ID of the security group"
  value       = aws_security_group.rds.vpc_id
}

output "debug_vpc_database_subnet_group" {
  description = "Database subnet group name"
  value       = module.vpc.database_subnet_group
}