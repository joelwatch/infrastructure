variable "prefix" {
  description = "Prefix for resources"
  type = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type = string
  validation {
    condition = contains(["dev", "test", "prod"], var.environment)
    error_message = "The environment most be 'dev', 'test', 'prod' ."
  }
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_count" {
  description = "Total numbers of subnets to create"
  type = number
  default = 7
  validation {
    condition = var.subnet_count >= 6
    error_message = "Minimum subnet count is 6"
  }
}

variable "enable_nat_gateway" {
  type = bool
  default = 6
}

variable "single_nat_gateway" {
  type = bool
  default = 6
}

variable "aws_region" {
  type = string
}