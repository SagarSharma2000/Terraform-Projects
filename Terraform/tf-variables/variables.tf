variable "aws_instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
  
  validation {
    condition = var.aws_instance_type == "t3.micro" || var.aws_instance_type == "t2.micro"
    error_message = "The instance type must be either 't3.micro' or 't2.micro'."
  }
}

/*variable "root_volume_size" {
  description = "The size of the root volume in GB."
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "The type of the root volume."
  type        = string
  default     = "gp2"
}
*/

variable "root_block_config" {
    type = object({
       volume_size = number
       volume_type = string
    })
    default = {
        volume_size = 8
        volume_type = "gp2"
    }
}

variable "additional_tags" {
    type = map(string) #expecting key=value format
    default = {}
}