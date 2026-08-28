resource "aws_instance" "my_instance" {
  ami           = "ami-0011550b539717e2a" # RedHat AMI ID for region
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "my_instance_Public_subnet"
  }
}
