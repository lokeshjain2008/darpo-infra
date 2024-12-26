output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "db_instance_endpoint" {
  description = "The connection endpoint for RDS"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_address" {
  description = "The hostname of the RDS instance"
  value       = module.rds.db_instance_address
}