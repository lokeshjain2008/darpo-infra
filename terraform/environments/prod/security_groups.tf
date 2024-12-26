resource "aws_security_group" "rds" {
  name        = "darpo-${var.environment}-rds"
  description = "Security group for RDS PostgreSQL in production"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "PostgreSQL from EKS"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [module.eks.cluster_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "darpo-${var.environment}-rds"
    Environment = var.environment
    Terraform   = "true"
    ManagedBy   = "terraform"
  }
}