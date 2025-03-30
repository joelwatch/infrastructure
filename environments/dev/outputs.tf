output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}

output "argocd_admin_password" {
  value     = module.argocd.admin_password
  sensitive = true
}

output "vpc_id" {
  value = module.vpc.vpc_id
}