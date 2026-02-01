output "ec2_pubip" {
    value = aws_instance.ec2_server.public_ip
  }

output "bhupendra_vpc_cidr" {
  value = aws_vpc.main.cidr_block
  
}

output "bhupendra_instance_key" {
  value = aws_instance.ec2_server.key_name
  
}