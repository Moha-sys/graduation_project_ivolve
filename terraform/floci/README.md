# Floci - Fast Local Cloud Emulator for AWS

Floci is an ultra-fast, lightweight, open-source local cloud service emulator (drop-in replacement for LocalStack). In this project, it is used to emulate AWS services locally without requiring live AWS credentials or incurring cloud bills.

## Emulated Services
- **S3:** Terraform remote backend state (`ivolve-terraform-state-bucket`).
- **EC2:** Virtual Private Cloud (VPC), Subnets, Route Tables, Internet Gateways, NAT Gateways, Network ACLs, and Jenkins Server.
- **EKS:** Elastic Kubernetes Service cluster and managed node groups.
- **ECR:** Elastic Container Registry for frontend, auth-service, and roadmap-service.
- **IAM / STS:** Roles, instance profiles, and policy attachments.

## Starting Floci

```bash
# 1. Spin up Floci via Docker Compose
docker compose -f terraform/floci/docker-compose.floci.yml up -d

# 2. Verify Floci is healthy on port 4566
curl http://localhost:4566

# 3. Create the Terraform Backend S3 Bucket
chmod +x terraform/floci/init-floci-s3.sh
./terraform/floci/init-floci-s3.sh
```

## Running Terraform against Floci

```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```
