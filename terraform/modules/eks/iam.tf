# IAM role for GitHub Actions
resource "aws_iam_role" "github_actions" {
  name = "darpo-${var.environment}-github-actions"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      }
    ]
  })

  tags = {
    Environment = var.environment
    Project     = "darpo"
  }
}

# Policy for GitHub Actions role
resource "aws_iam_role_policy" "github_actions" {
  name = "darpo-${var.environment}-github-actions"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:*",
          "ecr:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster"
        ]
        Resource = module.eks.cluster_arn
      }
    ]
  })
}

# Add GitHub Actions role to EKS auth configmap
resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

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

  depends_on = [module.eks.cluster_id]
}