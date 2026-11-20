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

variable "vpc_id" {
  description = "VPC ID where the server will reside"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the Jenkins EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu / Amazon Linux (can be dummy in Floci)"
  type        = string
  default     = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS us-east-1
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "ivolve-key"
}
