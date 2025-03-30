variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for all resources"
}

variable "app_name" {
  type        = string
  description = "Application name (used in resource naming)"
}

variable "domain_suffix" {
  type        = string
  description = "Domain suffix for ArgoCD ingress (e.g., 'mycompany.com')"
}

variable "cluster_version" {
  type        = string
  default     = "1.28"
  description = "EKS cluster version"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.1.0.0/16"  # Different CIDR than dev
  description = "VPC CIDR block"
}

variable "azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]  # 3 AZs for HA
  description = "Availability zones"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  description = "Private subnets"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
  description = "Public subnets"
}

variable "argocd_admin_password" {
  type        = string
  sensitive   = true
  description = "ArgoCD admin password (leave empty to auto-generate)"
}