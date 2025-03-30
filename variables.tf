variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "ha-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "node_groups" {
  description = "Configuration for EKS node groups"
  type = map(object({
    desired_size = number
    max_size     = number
    min_size     = number
    instance_type = string
  }))
  default = {
    primary = {
      desired_size  = 3
      max_size      = 6
      min_size      = 3
      instance_type = "m5.large"
    }
  }
}

variable "ecr_repositories" {
  description = "List of ECR repositories to create"
  type        = list(string)
  default     = ["app-frontend", "app-backend"]
}

variable "argocd_version" {
  description = "Version of ArgoCD to deploy"
  type        = string
  default     = "5.46.8"
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

variable "argocd_applications" {
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

variable "loki_version" {
  description = "Version of Loki to deploy"
  type        = string
  default     = "5.31.0"
}

variable "promtail_version" {
  description = "Version of Promtail to deploy"
  type        = string
  default     = "6.15.1"
}