## Main

resource "aws_s3_bucket" "s3_gdp" {
  provider = aws.localstack
  bucket   = "${var.env}-s3-gdp"
  force_destroy = true

  tags = {
    Name        = "${var.env}-s3"
    Environment = var.env
  }
}