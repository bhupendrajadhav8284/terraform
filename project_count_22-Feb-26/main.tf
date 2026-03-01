/*
resource "aws_instance" "my_ec2" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t3.micro"
    availability_zone = var.az[count.index]
    count = length(var.az)
    

    tags = {
      Name = "webserver-${count.index + 1}"
    }
}
*/

resource "aws_iam_user" "users" {
    name = var.userlist[count.index]
    count = length(var.userlist)
  
}