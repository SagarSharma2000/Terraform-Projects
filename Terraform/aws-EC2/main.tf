terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
    ami           = "ami-01a00762f46d584a1" # Replace with your desired AMI ID
    instance_type = "t3.small" # Replace with your desired instance type    
  
  tags = {
    Name = "MyInstance"
  }
}
