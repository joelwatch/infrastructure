output "repository_urls" {
  value       = module.ecr_repositories.repository_urls
  description = "ECR repository URLs"
}