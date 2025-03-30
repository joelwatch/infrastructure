output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}

output "argocd_url" {
  value = "https://${module.argocd.server_url}"
}

output "monitoring_endpoints" {
  value = {
    prometheus = module.monitoring.prometheus_endpoint
    grafana    = module.monitoring.grafana_endpoint
    loki       = module.monitoring.loki_endpoint
  }
}