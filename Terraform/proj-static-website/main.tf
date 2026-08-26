terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
     random = {
      source  = "hashicorp/random"
      version = "3.9.0"
  }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "mywebapp-bucket" {
    bucket = "my-bucket-${random_id.rand_id.hex}" # Change this to a unique bucket name

}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp-bucket-policy" {
  bucket = aws_s3_bucket.mywebapp-bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject"
        ]
        Resource  = [
          "${aws_s3_bucket.mywebapp-bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.mywebapp-bucket.bucket
    source = "./index.html" # Path to the file you want to upload
    key = "index.html"
    content_type = "text/html"
 
}

resource "aws_s3_object" "style_css" {
    bucket = aws_s3_bucket.mywebapp-bucket.bucket
    source = "./style.css" # Path to the file you want to upload
    key = "style.css"
    content_type = "text/css"
}

output "name" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}