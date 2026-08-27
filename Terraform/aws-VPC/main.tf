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

#Create a VPC
resource "aws_vpc" "my_vpc" {
 cidr_block = "10.0.0.0/16"

 tags = {
    Name = "my_vpc"
  }
}
  #Private subnet
  resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.0.1.0/24"

    tags = {
      Name = "private_subnet"
    }
  }

#Public subnet
    resource "aws_subnet" "public_subnet" {
        vpc_id            = aws_vpc.my_vpc.id
        cidr_block        = "10.0.2.0/24"
     tags = {
      Name = "public_subnet"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}

#Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"    
    gateway_id = aws_internet_gateway.my_igw.id
    }   
    tags = {
        Name = "Internet_gateway_route_table"
    }
}
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0011550b539717e2a" # RedHat AMI ID for region
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "my_instance_Public_subnet"
  }
}

