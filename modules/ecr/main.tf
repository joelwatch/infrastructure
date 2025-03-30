resource "aws_ecr_repository" "this" {
  for_each = toset(var.repository_names)

  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key        = var.encryption_type == "KMS" ? var.kms_key_arn : null
  }

  tags = merge(
    var.tags,
    {
      Name = each.value
    }
  )
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = var.lifecycle_policies

  repository = aws_ecr_repository.this[each.key].name
  policy     = each.value
}