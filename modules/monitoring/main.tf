resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = var.loki_version
  namespace  = var.namespace
  create_namespace = true

  values = [
    templatefile("${path.module}/loki-values.yaml", {
      persistence_enabled = var.loki_persistence_enabled
      persistence_size    = var.loki_storage_size
      retention_period    = var.loki_retention_period
    })
  ]
}

resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = var.promtail_version
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/promtail-values.yaml", {
      loki_address = "http://loki-${helm_release.loki.name}.${var.namespace}.svc.cluster.local:3100/loki/api/v1/push"
    })
  ]
}

resource "helm_release" "prometheus" {
  count = var.enable_prometheus ? 1 : 0

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.prometheus_version
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/prometheus-values.yaml", {
      enable_alertmanager = var.enable_alertmanager
    })
  ]
}