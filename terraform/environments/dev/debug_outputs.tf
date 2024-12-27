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

output "debug_vpc_database_subnets" {
  description = "Database subnet IDs"
  value       = module.vpc.database_subnets
}