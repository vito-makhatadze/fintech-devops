output "argocd_access" {
  description = "Command to access ArgoCD locally"
  value       = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

output "vault_access" {
  description = "Command to access Vault locally"
  value       = "kubectl port-forward svc/vault -n vault 8200:8200"
}

output "argocd_admin_password" {
  description = "Command to get ArgoCD admin password"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}

output "kyc_service_status" {
  description = "Command to check kyc-service pod status"
  value       = "kubectl get pods -n ${var.namespace_kyc}"
}