### Main
## AWS
# S3
module "s3_gdp" {
  source      = "../../modules/aws/s3"
  bucket_name = "${var.env}-s3-gdp"

  tags = {
    environment = var.env
  }

  providers = {
    aws = aws.localstack
  }
}
