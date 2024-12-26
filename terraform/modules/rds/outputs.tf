output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.db.db_instance_endpoint
}

output "db_instance_name" {
  description = "The database name"
  value       = module.db.db_instance_name
}

output "db_instance_port" {
  description = "The database port"
  value       = module.db.db_instance_port
}

output "db_subnet_group_name" {
  description = "The database subnet group name"
  value       = module.db.db_subnet_group_name
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = module.db.db_instance_id
}