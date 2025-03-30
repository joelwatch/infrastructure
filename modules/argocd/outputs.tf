output "server_url" {
  description = "URL of the ArgoCD server"
  value       = try("http://${data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname}", "")
}

output "admin_password" {
  description = "Initial admin password for ArgoCD"
  value       = try(data.kubernetes_secret.argocd_admin_password.data.password, "")
  sensitive   = true
}