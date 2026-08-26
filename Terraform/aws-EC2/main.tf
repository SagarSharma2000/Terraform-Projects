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
  region = var.aws_region
}

resource "aws_instance" "my_instance" {
    ami           = "ami-01a00762f46d584a1" # Ubuntu AMI ID for ap-south-1 region (as of the time of writing)
    instance_type = "t3.micro" # Free tier eligible instance type    
  
  tags = {
    Name = "MyInstance"
  }
}

