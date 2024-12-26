variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "single_nat_gateway" {
  type    = bool
  default = true
  description = "Should only a single NAT Gateway be created?"
}