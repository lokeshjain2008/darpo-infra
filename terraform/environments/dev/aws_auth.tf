# AWS Auth ConfigMap configuration
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
          rolearn  = aws_iam_role.github_actions.arn
          username = "github-actions"
          groups   = ["system:masters"]
        }
      ]
    )
  }

  depends_on = [module.eks]
}