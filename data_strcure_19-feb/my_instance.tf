/*
variable "my_map" {
    type = map
    default = {
        india = "t2.micro",
        us = "t3.micro"

    }
  
}

resource "aws_instance" "my_instance" {
    ami = "ami-123"
    instance_type = var.my_map ["us"]

  
}
*/

# variable "types" {
#     type = list
#     default = ["us-east-1a","us-east-1b"]
  
# }

resource "aws_instance" "my_ec2" {
    ami = "ami-04752fceda1274920"
    instance_type = "t3.micro"
    count = 2
  
}




