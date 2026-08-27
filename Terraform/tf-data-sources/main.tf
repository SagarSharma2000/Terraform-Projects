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

data "aws_ami" "name" {
 most_recent = true
 owners      = ["amazon"] 
}

output "aws_ami" {
    value = data.aws_ami.name.id
}

data "aws_security_group" "name" {
    tags = {
        mywebserver = "http"
    }
}

output "security_group_id" {
    value = data.aws_security_group.name.id
}

data "aws_vpc" "name" {
    tags = {
        Name = "myvpc"
    }
}
output "vpc_id" {
    value = data.aws_vpc.name.id
}

data "aws_availability_zones" "available" {
    state = "available"
}
output "availability_zones" {
    value = data.aws_availability_zones.available.names
}

#To get the account details
data "aws_caller_identity" "current" {}
output "account_id" {
    value = {
     id = data.aws_caller_identity.current.account_id
     arn = data.aws_caller_identity.current.arn
     user_id = data.aws_caller_identity.current.user_id
}
}

#To get the region details
data "aws_region" "current" {}
output "region" {
    value = {
      region  = data.aws_region.current.region
      description = data.aws_region.current.description
      endpoint = data.aws_region.current.endpoint
}
}

resource "aws_instance" "my_instance" {
    ami           = data.aws_ami.name.id
    instance_type = "t3.micro" # Free tier eligible instance type    
  
  tags = {
    Name = "MyInstance"
  }
}
