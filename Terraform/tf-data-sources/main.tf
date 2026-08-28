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




resource "aws_instance" "my_instance" {
    ami           = "ami-0ac7b260cf76d8865"
    instance_type = "t3.micro" # Free tier eligible instance type
    subnet_id     = data.aws_subnet.my_subnet_ids.id # Use the first subnet from the list
    vpc_security_group_ids = [data.aws_security_group.name.id] # Use the security    
  
  tags = {
    Name = "MyInstance"
  }
}

