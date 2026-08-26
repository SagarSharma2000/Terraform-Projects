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
  region = var.aws_region
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "my-bucket-${random_id.rand_id.hex}" # Change this to a unique bucket name

}

resource "aws_s3_object" "bucket_data" {
    bucket = aws_s3_bucket.my_bucket.bucket
    source = "./myfile.txt" # Path to the file you want to upload
    key = "myfile.txt"
 
}
