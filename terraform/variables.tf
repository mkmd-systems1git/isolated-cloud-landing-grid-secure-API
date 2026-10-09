variable "aws_region" {
  type        = string
  description = "The primary cloud data center region for centralized data hub operations"
  default     = "eu-west-1" # Ireland data center (geographically optimal for Europe/Africa routing)
}

variable "environment_name" {
  type        = string
  description = "The master naming convention for the isolated infrastructure system grid"
  default     = "secure-enterprise-landing-zone"
}
