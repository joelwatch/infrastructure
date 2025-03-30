output "loki_endpoint" {
  description = "Loki endpoint"
  value       = "http://loki-${helm_release.loki.name}.${var.namespace}.svc.cluster.local:3100"
}

output "prometheus_endpoint" {
  description = "Prometheus endpoint"
  value       = var.enable_prometheus ? "http://prometheus-${helm_release.prometheus[0].name}.${var.namespace}.svc.cluster.local:9090" : null
}

output "grafana_endpoint" {
  description = "Grafana endpoint"
  value       = var.enable_prometheus ? "http://grafana.${var.namespace}.svc.cluster.local:3000" : null
}