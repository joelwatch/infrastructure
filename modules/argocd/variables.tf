variable "cluster_name" {
  description = "Name of the EKS cluster (used for naming resources)"
  type        = string
}

variable "argocd_version" {
  description = "Version of ArgoCD to deploy"
  type        = string
}

variable "github_repo_url" {
  description = "URL of the GitHub repository containing application manifests"
  type        = string
}

variable "github_repo_branch" {
  description = "Branch of the GitHub repository to use"
  type        = string
  default     = "main"
}

variable "applications" {
  description = "List of ArgoCD applications to create"
  type = list(object({
    name           = string
    path           = string
    repo_url       = string
    target_revision = string
    destination_server = string
  }))
  default = []
}