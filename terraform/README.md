# Terraform Infrastructure as Code (AWS & Floci)

This directory contains modular Terraform configuration for provisioning the complete cloud infrastructure. Per project requirements, **Floci** is supported as a drop-in local AWS emulator.

## Modules Structure

1. **`modules/network`**:
   - VPC (`10.0.0.0/16`)
   - 2 Public Subnets & 2 Private Subnets across 2 Availability Zones (`us-east-1a`, `us-east-1b`)
   - Internet Gateway (IGW)
   - NAT Gateway & Elastic IP
   - Public and Private Route Tables
   - Public & Private Network ACLs (NACL)
2. **`modules/server`**:
   - Jenkins EC2 instance with dedicated security group (ports 22, 8080, 50000)
   - IAM Role & Instance Profile for ECR/EKS access
3. **`modules/eks`**:
   - EKS Cluster in private subnets
   - Managed Node Group with 2 worker nodes across multiple AZs
   - IAM Roles for Cluster and Node Group
4. **`modules/ecr`**:
   - ECR repositories for `ivolve-frontend`, `ivolve-auth-service`, and `ivolve-roadmap-service`
   - Image scanning on push & lifecycle policies

## Remote State Backend

Terraform state is saved in an S3 bucket (`ivolve-terraform-state-bucket`) configured in `backend.tf`.

## Usage with Floci (Local AWS Emulation)

```bash
# 1. Start Floci
docker compose -f floci/docker-compose.floci.yml up -d

# 2. Initialize S3 Backend
chmod +x floci/init-floci-s3.sh && ./floci/init-floci-s3.sh

# 3. Initialize & Apply Terraform
terraform init
terraform plan
terraform apply -auto-approve
```
