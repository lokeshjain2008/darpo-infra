variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_]*$", var.db_username))
    error_message = "The db_username must start with a letter and contain only alphanumeric characters and underscores."
  }
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "dev.darpo.example.com"
}