variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "ivolve"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "AWS region (or Floci default region)"
  type        = string
  default     = "us-east-1"
}

# Floci Emulator Settings
variable "use_floci" {
  description = "Enable Floci local AWS emulator instead of real AWS"
  type        = bool
  default     = true
}

variable "floci_endpoint" {
  description = "Endpoint URL for Floci emulator"
  type        = string
  default     = "http://localhost:4566"
}

# Network Configuration
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDRs"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Jenkins Server Configuration
variable "jenkins_instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}

variable "jenkins_ami_id" {
  description = "AMI ID for Jenkins EC2"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "ssh_key_name" {
  description = "SSH Key Pair name"
  type        = string
  default     = "ivolve-key"
}

# EKS Cluster Configuration
variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "ivolve-eks-cluster"
}

variable "eks_node_instance_types" {
  description = "EKS Node Group Instance Types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "eks_min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "eks_max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}
