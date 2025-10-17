# Bucket S3 para AWS real (apenas se use_local_stack = false)
resource "aws_s3_bucket" "s3_gdp" {
  provider = aws
  bucket   = "${var.env}-s3-gdp"
  force_destroy = true

  tags = {
    Name        = "${var.env}-s3"
    Environment = var.env
  }
}