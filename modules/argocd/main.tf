resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml", {
      # Pass variables to the template
      server_service_type = var.server_service_type
      enable_ingress      = var.enable_ingress
      ingress_host        = var.ingress_host
      admin_password      = var.admin_password != "" ? var.admin_password : random_password.argocd.result
    })
  ]
}

resource "random_password" "argocd" {
  length  = 16
  special = false
}