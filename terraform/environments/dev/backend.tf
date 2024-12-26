terraform {
  backend "s3" {
    bucket         = "darpo-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "darpo-terraform-lock"
    encrypt        = true
  }
}