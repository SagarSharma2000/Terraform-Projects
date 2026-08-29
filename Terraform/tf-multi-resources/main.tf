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

locals {
    project = "project-01"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.project}-vpc"
    }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  count            = 2
    availability_zone = "${var.aws_region}a"
        tags = {
            Name = "${local.project}-subnet-${count.index}"
        }
}

#Creating for EC2 Instance Task 2
/* resource "aws_instance" "my_instance" {
  ami           = "ami-0ac7b260cf76d8865" #Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
  count         = 4
  subnet_id     = element(aws_subnet.my_subnet[*].id, count.index % length(aws_subnet.my_subnet))
 #0%2 = 0, 
 #1%2 = 1, 
 #2%2 = 0, 
 #3%2 = 1
 
  tags = {
    Name = "${local.project}-instance-${count.index}-subnet-${count.index % length(aws_subnet.my_subnet)}"
  }
}
*/

#Creating for EC2 Instance Task 3
resource "aws_instance" "my_instance" {
  count = length(var.ec2_config)

  ami   = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type

subnet_id = element(aws_subnet.my_subnet[*].id, count.index% length(aws_subnet.my_subnet))
#0%2 = 0
#1%2 = 1
  tags = {
    Name = "${local.project}-instance-${count.index}-subnet-${count.index % length(aws_subnet.my_subnet)}"
  }
}

output "aws_subnet_id" {
  value = aws_subnet.my_subnet[*].id
}

 