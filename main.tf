module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = var.vpc_cidr

  azs  = local.availability_zones
  public_subnets = local.public_subnets
  private_subnets = local.private_subnets
  database_subnets = local.database_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_dns_hostnames = true
  enable_dns_support = true
  enable_vpn_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
  tags = {
    Environment = var.environment
    Terraform = "true"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id = module.vpc.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = module.vpc.private_route_table_ids

  tags = {
    Name = "${local.name}-s3-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id = module.vpc.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.vpc.private_subnets
  security_group_ids = [aws_security_group.vpc_endpoints_id]
  private_dns_enabled = true

  tags = {
    Name = "${local.name}-ecr-api-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id = module.vpc.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids = module.vpc.private_subnets
  security_group_ids = [aws_security_group.vpc_endpoints_id]
  private_dns_enabled = true

  tags = {
    Name = "${local.name}-ecr-dkr-endpoint"
    Environment = var.environment
  }
}

resource "aws_security_group" "vpc-endpoints" {
  name_prefix = "${local.name}-vpc-endpoints-"
  description = "Securitu group for vpc endpoints"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
    Name = "${local.name}-vpc-endpoints-sg"
    Environment = var.environment
  }
}