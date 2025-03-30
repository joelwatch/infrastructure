output "loki_endpoint" {
  description = "Endpoint for Loki"
  value       = "http://loki.monitoring.svc.cluster.local:3100"
}

output "grafana_endpoint" {
  description = "Endpoint for Grafana (if deployed)"
  value       = "http://grafana.monitoring.svc.cluster.local:3000"
}