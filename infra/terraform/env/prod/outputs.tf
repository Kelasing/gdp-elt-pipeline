### Outputs
## AWS
# S3
output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = module.s3_gdp.bucket_name
}