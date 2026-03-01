resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true

    tags = {
      Name = "demo_vpc"
    }
  }

resource "aws_subnet" "pubsub" {
    count = 2
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.${count.index}.0/24"
    availability_zone = ["us-east-1a","us-east-1b"][count.index]

    tags = {
      Name = "pubsub${count.index}"
    }
  
}

resource "aws_subnet" "prisub" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = "10.1.${count.index}.0/24"
  availability_zone = ["us-east-1a","us-east-1b"][count.index]

  tags = {
    Name = "prisub{$count.index}"
  }
  
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
    
}

resource "aws_route_table" "name" {
  
}

/*
resource "aws_subnet" "pubsub2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    
    tags = {
      Name = "pubsub2"
    }   
}


resource "aws_subnet" "prisub1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "prisub2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "pubrt_1" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "public_RT_1"
    }
  
}

resource "aws_route_table" "pubrt_2" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "public_RT_2"
    }
}

resource "aws_route" "internet_access1" {
    route_table_id = aws_route_table.pubrt_1.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
    
}

resource "aws_route" "internet_access2" {
    route_table_id = aws_route_table.pubrt_2.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  
}

resource "aws_route_table_association" "public_internet_access_1" {
    subnet_id = aws_subnet.pubsub1.id
    route_table_id = aws_route_table.pubrt_1.id
  
}

resource "aws_route_table_association" "public_internet_access_2" {
    subnet_id = aws_subnet.pubsub2.id
    route_table_id = aws_route_table.pubrt_2.id
  
}

resource "aws_security_group" "main1" {
    name = "main_sg1"
    description = "my sec1 group"
    vpc_id = aws_vpc.main.id
  
}

resource "aws_security_group" "main2" {
    name = "main_sg2"
    description = "my sec2 group"
    vpc_id = aws_vpc.main.id
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh1" {
  security_group_id = aws_security_group.main1.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_httpd1" {
  security_group_id = aws_security_group.main1.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh2" {
  security_group_id = aws_security_group.main2.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_httpd2" {
  security_group_id = aws_security_group.main2.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}


resource "null_resource" "generate_pubkey" {
  provisioner "local-exec" {
    command = "ssh-keygen -y -f aws-jan26.pem > aws-jan26.pub"
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "aws-jan26"
  public_key = file("${path.module}/aws-jan26.pub")

  depends_on = [null_resource.generate_pubkey]
}




resource "aws_instance" "ec2_server_1" {
  ami = "ami-0b6c6ebed2801a5cb"
  instance_type = "t3.micro"
  availability_zone = "us-east-1a"
  subnet_id = aws_subnet.pubsub1.id
  key_name = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.main1.id]
  associate_public_ip_address = true

  tags = {
    Name = "terraform_ec2"

  }
  
}

resource "aws_instance" "ec2_server_2" {
  ami = "ami-0b6c6ebed2801a5cb"
  instance_type = "t3.micro"
  availability_zone = "us-east-1b"
  subnet_id = aws_subnet.pubsub2.id
  key_name = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.main2.id]
  associate_public_ip_address = true

  tags = {
    Name = "terraform_ec2"
  }    

  }

*/
