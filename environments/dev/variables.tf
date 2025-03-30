variable "aws_region" {
  type        = string
  default     = "us-east-1"  # Explicitly set here
  description = "AWS region for all resources"
}

variable "app_name" {
  type        = string
  description = "Application name (used in resource naming)"
}

# ... (keep other variables from previous example) ...
variable "app_name" {
  type        = string
  description = "Application name (used in resource naming)"
}

variable "cluster_version" {
  type        = string
  default     = "1.28"
  description = "EKS cluster version"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
}

variable "azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "Availability zones"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "Private subnets"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
  description = "Public subnets"
}

variable "argocd_admin_password" {
  type        = string
  default     = ""
  sensitive   = true
  description = "ArgoCD admin password (leave empty to auto-generate)"
}