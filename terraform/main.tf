# Module 1: Network Provisioning (VPC, Subnets, IGW, NAT, NACLs)
module "network" {
  source = "./modules/network"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# Module 2: Server Provisioning (Jenkins EC2 with Security Groups)
module "server" {
  source = "./modules/server"

  project_name  = var.project_name
  environment   = var.environment
  vpc_id        = module.network.vpc_id
  subnet_id     = module.network.public_subnet_ids[0]
  instance_type = var.jenkins_instance_type
  ami_id        = var.jenkins_ami_id
  key_name      = var.ssh_key_name
}

# Module 3: EKS Provisioning (EKS Cluster with 2 worker nodes in private subnets)
module "eks" {
  source = "./modules/eks"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  cluster_name        = var.eks_cluster_name
  node_instance_types = var.eks_node_instance_types
  desired_capacity    = var.eks_desired_capacity
  min_capacity        = var.eks_min_capacity
  max_capacity        = var.eks_max_capacity
}

# Module 4: ECR Repositories Provisioning
module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
  repository_names = [
    "ivolve-frontend",
    "ivolve-auth-service",
    "ivolve-roadmap-service"
  ]
}
