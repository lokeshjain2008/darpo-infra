# Add GitHub Actions role to aws-auth ConfigMap
resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  force = true

  data = {
    mapRoles = yamlencode(
      [
        {
          rolearn  = module.eks.github_actions_role_arn
          username = "github-actions"
          groups   = ["system:masters"]
        }
      ]
    )
  }

  depends_on = [module.eks]
}