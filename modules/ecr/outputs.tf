output "repository_urls" {
  description = "Map of repository names to their URLs"
  value       = { for repo in aws_ecr_repository.this : repo.name => repo.repository_url }
}

output "repository_arns" {
  description = "Map of repository names to their ARNs"
  value       = { for repo in aws_ecr_repository.this : repo.name => repo.arn }
}

output "registry_id" {
  description = "Registry ID where repositories were created"
  value       = length(aws_ecr_repository.this) > 0 ? aws_ecr_repository.this[keys(aws_ecr_repository.this)[0]].registry_id : null
}