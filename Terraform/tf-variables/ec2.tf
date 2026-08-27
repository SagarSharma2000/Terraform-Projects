resource "aws_instance" "myserver" {
    ami           = "ami-0ac7b260cf76d8865"
    instance_type = var.aws_instance_type # Free tier eligible instance type
  
    root_block_device {
        delete_on_termination = true
        volume_size = var.root_block_config.volume_size
        volume_type = var.root_block_config.volume_type
    }

    tags = merge(var.additional_tags, {
        Name = local.name
    })
    }
