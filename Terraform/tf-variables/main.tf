terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.62.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

locals {
  owner = "ABC"
  name  = "MyServer"
}