#EC2 instance for Nginx server
resource "aws_instance" "nginx_server" {
  ami           = "ami-0ac7b260cf76d8865" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id
# Security group to allow HTTP traffic
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true

 user_data = <<-EOF
              #!/bin/bash
              sudo yum install nginx -y
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "nginx_server"
  }

 

  
}