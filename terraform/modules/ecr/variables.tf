variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "ivolve"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "repository_names" {
  description = "List of ECR repository names to create"
  type        = list(string)
  default     = [
    "ivolve-frontend",
    "ivolve-auth-service",
    "ivolve-roadmap-service"
  ]
}
