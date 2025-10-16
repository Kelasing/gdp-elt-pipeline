provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "s3_gdp" {
  bucket        = "${var.env}-s3-gdp"
  force_destroy = true

  tags = {
    Name        = "${var.env}-s3"
    Environment = var.env
  }
}
