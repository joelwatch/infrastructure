output "admin_password" {
  description = "ArgoCD admin password"
  value       = var.admin_password != "" ? var.admin_password : random_password.argocd.result
  sensitive   = true
}

output "server_url" {
  description = "ArgoCD server URL"
  value       = var.enable_ingress ? "https://${var.ingress_host}" : null
}