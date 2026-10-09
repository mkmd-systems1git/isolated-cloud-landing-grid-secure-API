# Provision a secure, highly scalable cloud storage vault for historical data logs
resource "aws_s3_bucket" "secure_vault" {
  bucket        = "universal-enterprise-telemetry-vault-mkmd"
  force_destroy = true

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform-IaC"
  }
}

# Enforce strict encryption protocols on all incoming ship data streams at rest
resource "aws_s3_bucket_server_side_encryption_configuration" "vault_security" {
  bucket = aws_s3_bucket.secure_vault.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Export the secure storage bucket ID so it can be read by the master control cockpit
output "vault_id" {
  value = aws_s3_bucket.secure_vault.id
}
