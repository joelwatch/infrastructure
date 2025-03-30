terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "prod-${var.app_name}-vpc"
  cidr = var.vpc_cidr
  azs  = var.azs

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = false  # High availability in prod
  one_nat_gateway_per_az = true
}

module "eks" {
  source = "../../modules/eks"

  cluster_name    = "prod-${var.app_name}-cluster"
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  cluster_enabled_log_types = ["api", "audit", "authenticator"]  # Enhanced logging

  node_groups = {
    prod-primary = {
      instance_type   = "m5.large"
      desired_size    = 3
      max_size        = 6
      min_size        = 3
      capacity_type   = "ON_DEMAND"
      labels = {
        "nodeclass" = "ondemand"
      }
    },
    prod-spot = {
      instance_type   = "m5.large"
      desired_size    = 3
      max_size        = 6
      min_size        = 3
      capacity_type   = "SPOT"
      labels = {
        "nodeclass" = "spot"
      }
    }
  }
}

module "ecr" {
  source = "../../modules/ecr"

  repository_names       = ["prod-${var.app_name}-backend", "prod-${var.app_name}-frontend"]
  image_tag_mutability  = "IMMUTABLE"  # Critical for production
  scan_on_push          = true
}

module "argocd" {
  source = "../../modules/argocd"

  namespace        = "argocd-prod"
  enable_ingress   = true
  ingress_host     = "argocd.${var.domain_suffix}"
  admin_password   = var.argocd_admin_password
}

module "monitoring" {
  source = "../../modules/monitoring"

  namespace               = "monitoring-prod"
  loki_persistence_enabled = true
  loki_storage_size       = "50Gi"
  enable_alertmanager     = true
}