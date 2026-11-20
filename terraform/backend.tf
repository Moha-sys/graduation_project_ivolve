# S3 Backend configuration for Terraform State
# Pointed to Floci local S3 emulator (or AWS S3 in production)
terraform {
  backend "s3" {
    bucket                      = "ivolve-terraform-state-bucket"
    key                         = "production/terraform.tfstate"
    region                      = "us-east-1"
    endpoints                   = { s3 = "http://localhost:4566" }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}
