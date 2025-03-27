module "ecr_repositories" {
  source           = "./modules"
  project_name     = var.project_name
  repository_type  = var.repository_type
  repository_count = var.repository_count
  environment      = var.environment
  image_tag_mutability = "MUTABLE"
}