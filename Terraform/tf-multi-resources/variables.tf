variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type = string
    default = "ap-south-1"
  
}

/*
variable "ec2_config" {
    type = list(object({
      ami = string 
      instance_type =  string
    }))
}
*/

variable "ec2_map" {
    #key = value (objet{ami,instance})
    type = map(object({
        ami = string
        instance_type = string
    
    }))
}