#To get the aws ami details
data "aws_ami" "name" {
 most_recent = true
 owners      = ["amazon"] 
}

output "aws_ami" {
    value = data.aws_ami.name.id
}

#To get the Security Group
data "aws_security_group" "name" {
    tags = {
        mywebserver = "http"
    }
}

output "security_group_id" {
    value = data.aws_security_group.name.id
}

#To get the VPC details
data "aws_vpc" "name" {
    tags = {
        Name = "myvpc"
    }
}
output "vpc_id" {
    value = data.aws_vpc.name.id
}

#To get the Availability Zone details
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

#To get the Subnet details
data "aws_subnet" "my_subnet_ids" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.name.id]
    }
    tags = {
      Name = "private_subnet"
    }
}
output "subnet_ids" {
    value = data.aws_subnet.my_subnet_ids.id
}