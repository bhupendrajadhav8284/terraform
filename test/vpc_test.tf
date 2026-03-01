resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true

    tags = {
      Name = "bhupendra"
    }
    
}

resource "aws_subnet" "MY_PUB_SUB" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

    tags = {
      Name = my_pub_sub
    }
}

resource "aws_subnet" "MY_PRI_SUB" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

    tags = {
      Name = my_pri_sub
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = main
  }
  
}

resource "aws_route_table" "PUBRT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = public_route_table
  }
  
}

resource "aws_route_table" "PRIRT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = private_route_table
  }
  
}

resource "aws_route" "PUBRT" {
  route_table_id = aws_route_table.PUBRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_route_table.PUBRT.id
}

resource "aws_route_table_association" "public internet accesss" {
  subnet_id = aws_subnet.MY_PUB_SUB.id
  route_table_id = aws_route_table.PUBRT.id
  
}

resource "aws_security_group" "main" {
  name = "main_sg"
  description = "my sec group"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = main_sg
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow ssh" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4 = "0.0.0.0/16"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4 = "0.0.0.0/16"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80

}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "ec2_key_pair" {
  key_name   = "my_terraform_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}