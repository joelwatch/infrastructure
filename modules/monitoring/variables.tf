variable "namespace" {
  type        = string
  default     = "monitoring"
  description = "Namespace for monitoring tools"
}

variable "loki_version" {
  type        = string
  default     = "5.8.0"
  description = "Loki Helm chart version"
}

variable "promtail_version" {
  type        = string
  default     = "6.15.1"
  description = "Promtail Helm chart version"
}

variable "prometheus_version" {
  type        = string
  default     = "48.1.1"
  description = "Prometheus Helm chart version"
}

variable "loki_persistence_enabled" {
  type        = bool
  default     = true
  description = "Enable PVC for Loki"
}

variable "loki_storage_size" {
  type        = string
  default     = "10Gi"
  description = "Storage size for Loki"
}

variable "loki_retention_period" {
  type        = string
  default     = "720h" # 30 days
  description = "Log retention period"
}

variable "enable_prometheus" {
  type        = bool
  default     = true
  description = "Enable Prometheus stack"
}

variable "enable_alertmanager" {
  type        = bool
  default     = false
  description = "Enable Alertmanager"
}