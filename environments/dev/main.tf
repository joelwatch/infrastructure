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

  name = "dev-${var.app_name}-vpc"
  cidr = var.vpc_cidr
  azs  = var.azs

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source = "../../modules/eks"

  cluster_name    = "dev-${var.app_name}-cluster"
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id  # Now correctly references the VPC module
  subnet_ids      = module.vpc.private_subnets

  node_groups = {
    dev = {
      instance_type   = "t3.medium"
      desired_size    = 2
      max_size        = 3
      min_size        = 1
      capacity_type   = "ON_DEMAND"
    }
  }
}