# Establish the master cloud provider rules and version lock thresholds
terraform {
  required_version = ">= 1.0.0"
}

# Configure the live cloud engine with our regional control variables
provider "aws" {
  region                      = var.aws_region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

# Instantiate the isolated network security perimeter module
module "network_perimeter" {
  source = "./modules/security_perimeter"
}

# Instantiate the military-grade encrypted storage vault module
module "storage_vault" {
  source = "./modules/storage_vault"
}
