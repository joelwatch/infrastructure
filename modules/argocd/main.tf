resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = "argocd"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = "argocd.${var.cluster_name}.example.com"
  }
}

# Wait for ArgoCD to be deployed
resource "time_sleep" "wait_for_argocd" {
  depends_on = [helm_release.argocd]

  create_duration = "60s"
}

# Get the ArgoCD admin password
data "kubernetes_secret" "argocd_admin_password" {
  depends_on = [time_sleep.wait_for_argocd]

  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}

# Get the ArgoCD server service
data "kubernetes_service" "argocd_server" {
  depends_on = [time_sleep.wait_for_argocd]

  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }
}