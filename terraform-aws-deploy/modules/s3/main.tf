# Description: This file contains the configuration for the S3 buckets
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/s3/main.tf

resource "aws_s3_bucket" "conanthedeployer_bucket" {
  bucket = "conanthedeployer.com"  # Bucket names must be globally unique
  
  tags = {
    Name = "conanthedeployer.com"
  }
}

resource "aws_s3_bucket_ownership_controls" "conanthedeployer_bucket" {
  bucket = aws_s3_bucket.conanthedeployer_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "conanthedeployer_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.conanthedeployer_bucket]

  bucket = aws_s3_bucket.conanthedeployer_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "conanthedeployer_bucket" {
  bucket = aws_s3_bucket.conanthedeployer_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}