output "repository_urls" {
  value = {
    for type in var.repository_type : type => [
      for key, repo in aws_ecr_repository.repo : repo.repository_url
      if split("-", key)[0] == type
    ]
  }
  description = "ECR repository URLs"
}