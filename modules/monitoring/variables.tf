variable "cluster_name" {
  description = "Name of the EKS cluster (used for naming resources)"
  type        = string
}

variable "loki_version" {
  description = "Version of Loki to deploy"
  type        = string
}

variable "promtail_version" {
  description = "Version of Promtail to deploy"
  type        = string
}