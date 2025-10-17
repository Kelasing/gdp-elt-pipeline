variable "aws_access_key" {
  description = "AWS access key for production"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key for production"
  type        = string
  sensitive   = true
}

variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}