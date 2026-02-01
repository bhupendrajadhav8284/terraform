output "ec2_pubip" {
    value = aws_instance.ec2_server.public_ip
  }