resource "aws_ecr_repository" "repo" {
  # Générer une map avec des clés uniques pour chaque combinaison type + index
  for_each = {
    for pair in flatten([
      for type in var.repository_type : [
        for i in range(var.repository_count) : {
          type  = type
          index = i
        }
      ]
    ]) : "${pair.type}-${pair.index}" => pair
  }

  name = "${var.project_name}-${each.value.type}-${var.environment}-${each.value.index + 1}"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Type        = each.value.type
  }
}

resource "aws_ecr_lifecycle_policy" "policy" {
  # Lier chaque policy à un repository spécifique
  for_each   = aws_ecr_repository.repo
  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "keep 10 latest images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}