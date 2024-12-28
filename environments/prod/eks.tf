module "eks" {
  source = "../../modules/eks"

  cluster_name    = "darpo-prod"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  environment     = var.environment

  min_size        = 3
  max_size        = 10
  desired_size    = 3
  instance_types  = ["t3.large"]

  github_actions_role_external_id = var.github_actions_external_id

  tags = local.common_tags
}