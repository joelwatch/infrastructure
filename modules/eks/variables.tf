variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  default     = "1.28"
  description = "Kubernetes version"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the EKS cluster"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = true
  description = "Enable private access to the cluster API"
}

variable "cluster_endpoint_public_access" {
  type        = bool
  default     = true
  description = "Enable public access to the cluster API"
}

variable "cluster_security_group_ids" {
  type        = list(string)
  default     = []
  description = "Additional security group IDs for the cluster"
}

variable "cluster_enabled_log_types" {
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "List of control plane logs to enable"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags for all resources"
}

variable "node_groups" {
  type = map(object({
    instance_type   = string
    desired_size    = number
    max_size        = number
    min_size        = number
    max_unavailable = number
    capacity_type   = string
    labels          = map(string)
  }))
  default     = {}
  description = "Map of node group configurations"
}