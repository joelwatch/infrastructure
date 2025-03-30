output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_urls" {
  description = "URLs of the ECR repositories"
  value       = module.ecr.repository_urls
}

output "argocd_server_url" {
  description = "URL of the ArgoCD server"
  value       = module.argocd.server_url
}

output "argocd_admin_password" {
  description = "Initial admin password for ArgoCD"
  value       = module.argocd.admin_password
  sensitive   = true
}

output "loki_endpoint" {
  description = "Endpoint for Loki"
  value       = module.monitoring.loki_endpoint
}