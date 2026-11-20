resource "aws_ecr_repository" "repos" {
  count                = length(var.repository_names)
  name                 = var.repository_names[count.index]
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.repository_names[count.index]
    Environment = var.environment
  }
}

resource "aws_ecr_lifecycle_policy" "repo_policy" {
  count      = length(var.repository_names)
  repository = aws_ecr_repository.repos[count.index].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
