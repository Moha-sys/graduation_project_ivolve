output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.network.private_subnet_ids
}

output "jenkins_instance_id" {
  description = "Jenkins EC2 Instance ID"
  value       = module.server.jenkins_instance_id
}

output "jenkins_public_ip" {
  description = "Jenkins Server Public IP"
  value       = module.server.jenkins_public_ip
}

output "jenkins_security_group_id" {
  description = "Jenkins Security Group ID"
  value       = module.server.jenkins_security_group_id
}

output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API Endpoint"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_urls" {
  description = "ECR Repository URLs"
  value       = module.ecr.repository_urls
}
