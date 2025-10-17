## Variables
# Environment
variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# AWS Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}