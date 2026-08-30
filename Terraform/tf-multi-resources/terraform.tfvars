/*
#Used in task 3
ec2_config = [ {
  ami = "ami-01a00762f46d584a1" #Ubuntu
  instance_type = "t3.micro"
}, {
 ami = "ami-0ac7b260cf76d8865" #amazon linux
 instance_type = "t3.micro"
}
]
*/

ec2_map = {
  "ubuntu" = {
    ami = "ami-01a00762f46d584a1" #Ubuntu
  instance_type = "t3.micro"
  }
  "amazon-linux" = {
ami = "ami-0ac7b260cf76d8865" #amazon linux
 instance_type = "t3.micro"
  }
}