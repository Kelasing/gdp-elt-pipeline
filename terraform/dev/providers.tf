## Providers

# AWS LocalStack
provider "aws" {
  alias      = "localstack"
  region     = var.region
  access_key = "test"
  secret_key = "test"

  s3_use_path_style           = true
  skip_requesting_account_id  = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true

  endpoints {
    s3     = "http://localhost:4566"
    sqs    = "http://localhost:4566"
    sns    = "http://localhost:4566"
    lambda = "http://localhost:4566"
    events = "http://localhost:4566"
  }
}