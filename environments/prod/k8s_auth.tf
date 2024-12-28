# Create aws-auth ConfigMap after cluster is fully ready
resource "null_resource" "apply_aws_auth_cm" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = <<-EOT
      aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_id}
      kubectl apply -f - <<EOF
      apiVersion: v1
      kind: ConfigMap
      metadata:
        name: aws-auth
        namespace: kube-system
      data:
        mapRoles: |
          - rolearn: ${module.eks.github_actions_role_arn}
            username: github-actions
            groups:
              - system:masters
      EOF
    EOT
  }
}