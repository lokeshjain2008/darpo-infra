module "eks" {
  source = "../../modules/eks"

  cluster_name    = "darpo-dev"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  environment     = var.environment

  min_size        = 1
  max_size        = 4
  desired_size    = 2
  instance_types  = ["t3.medium"]

  github_actions_role_external_id = var.github_actions_external_id

  tags = local.common_tags
}