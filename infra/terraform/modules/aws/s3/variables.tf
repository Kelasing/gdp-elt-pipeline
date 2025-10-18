### Variables
# Bucket Name
variable "bucket_name" {
  description = "Bucket Name"
  type        = string
}

# Bucket Tags
variable "tags" {
  description = "Bucket Tags"
  type        = map(string)
  default     = {}
}
