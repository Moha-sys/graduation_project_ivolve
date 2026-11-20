output "repository_urls" {
  description = "Map of ECR repository names to their URLs"
  value = {
    for idx, repo in aws_ecr_repository.repos : repo.name => repo.repository_url
  }
}

output "repository_arns" {
  description = "List of ECR repository ARNs"
  value       = aws_ecr_repository.repos[*].arn
}
