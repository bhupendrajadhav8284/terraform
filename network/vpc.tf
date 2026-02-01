resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true

  tags = {
    Name = "bhupendra"
  }
}

resource "aws_subnet" "publicsub1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.pubsub1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "public1"
    } 
  }

resource "aws_subnet" "privatesub1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.privatesub1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "private1"
    }
  }

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "PUBRT" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = "Public_route_table"
  }

}

resource "aws_route_table" "PRIRT" {
  vpc_id = aws_vpc.main.id

  
  tags = {
    Name = "Private_route_table"
  }
  
}

resource "aws_route" "PUBROT" {
  route_table_id = aws_route_table.PUBRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id

}

resource "aws_route_table_association" "public_internet_access" {
  subnet_id = aws_subnet.publicsub1.id
  route_table_id = aws_route_table.PUBRT.id
}
  
resource "aws_security_group" "main" {
  name = "main_sg"
  description = "my sec group info"
  vpc_id = aws_vpc.main.id


  tags = {
    Name = "main_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
  
}

# resource "tls_private_key" "ec2_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "ec2_key_pair" {
#   key_name   = "my-terraform-key"  # Unique name for the key pair
#   public_key = tls_private_key.ec2_key.public_key_openssh
#   depends_on = [tls_private_key.ec2_key]

# }

resource "aws_instance" "ec2_server" {
  ami = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  availability_zone = "us-east-1a"  
  subnet_id = aws_subnet.publicsub1.id
  key_name = "aws-jan26"
  #key_name = aws_key_pair.ec2_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  associate_public_ip_address = true
  

  tags = {
    Name = "terraform_ec2"
  }
}