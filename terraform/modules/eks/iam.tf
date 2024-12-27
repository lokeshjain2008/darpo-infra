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
      }
    ]
  })
}

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
          rolearn  = aws_iam_role.github_actions.arn
          username = "github-actions"
          groups   = ["system:masters"]
        }
      ]
    )
  }

  depends_on = [module.eks]
}