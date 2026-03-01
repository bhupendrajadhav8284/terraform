resource "aws_instance" "my_vm" {
    ami = "ami-0532be01f26a3de55"
    availability_zone = "us-east-1a"
    instance_type = "t3.micro"

    tags = {
      Name : "linux_vm"
    }
}