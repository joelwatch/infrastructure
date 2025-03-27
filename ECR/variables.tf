variable "project_name" {
  type        = string
  description = "Project Name"
}

variable "repository_type" {
  type        = list(string)
  description = "list of repository type in ECR"
}

variable "repository_count" {
  type        = number
  description = "Nomber of repositories to create"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "environment" {
  type        = string
  description = "Environment (dev, prod, dev)"
}
