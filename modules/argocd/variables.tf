variable "namespace" {
  type        = string
  default     = "argocd"
  description = "Namespace for ArgoCD installation"
}

variable "chart_version" {
  type        = string
  default     = "5.46.8"
  description = "Helm chart version"
}

variable "server_service_type" {
  type        = string
  default     = "LoadBalancer"
  description = "Kubernetes Service type"
}

variable "enable_ingress" {
  type        = bool
  default     = false
  description = "Enable ingress for ArgoCD server"
}

variable "ingress_host" {
  type        = string
  default     = "argocd.example.com"
  description = "Ingress hostname"
}

variable "admin_password" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Admin password (leave empty to auto-generate)"
}