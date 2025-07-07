output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "configure_kubectl" {
  description = "Configure kubectl command"
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
}

output "argocd_server_url" {
  description = "ArgoCD server URL"
  value       = "kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}

output "argocd_admin_password" {
  description = "ArgoCD admin password command"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}

output "vault_server_url" {
  description = "Vault server URL"
  value       = "kubectl get svc vault -n vault -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}