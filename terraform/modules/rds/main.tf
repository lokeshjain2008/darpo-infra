module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "darpo-${var.environment}"

  engine                = "postgres"
  engine_version        = "15.4"  # Updated to available version
  family                = "postgres15"
  major_engine_version  = "15"
  instance_class        = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  port     = 5432

  multi_az               = var.multi_az
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Backup configuration
  backup_retention_period = var.environment == "prod" ? 30 : 7
  skip_final_snapshot    = var.environment != "prod"

  # Enhanced monitoring
  monitoring_interval    = var.environment == "prod" ? 60 : 0
  monitoring_role_name   = "darpo-${var.environment}-rds-monitoring-role"

  parameters = [
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "darpo"
  }
}