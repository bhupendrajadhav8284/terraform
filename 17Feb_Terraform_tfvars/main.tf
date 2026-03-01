resource "aws_instance" "my_ec1" {
    ami = var.ami
    instance_type = "t3.micro"
  
}