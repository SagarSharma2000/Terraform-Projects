aws_instance_type = "t2.micro"

root_block_config = {
  volume_size = 8
  volume_type = "gp3"
}

additional_tags = {
  DEPT ="QA"
  PROJECT = "Terraform"
}
