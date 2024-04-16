# Description: This file contains the configuration for the main Terraform deployment
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# main.tf


resource "aws_vpc" "conan_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "conan_vpc"
  }
}


resource "aws_subnet" "conan_public_subnet" {
  vpc_id                  = aws_vpc.conan_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "conan_public_subnet"
  }
}



resource "aws_internet_gateway" "conan_internet_gateway" {
  vpc_id = aws_vpc.conan_vpc.id

  tags = {
    Name = "conan_internet_gateway"
  }
}


resource "aws_route_table" "conan_public_rt" {
  vpc_id = aws_vpc.conan_vpc.id

  tags = {
    Name = "conan_public_rt"
  }
}

resource "aws_route" "conan_default_route" {
  route_table_id         = aws_route_table.conan_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.conan_internet_gateway.id
}


resource "aws_route_table_association" "conan_public_assoc" {
  subnet_id      = aws_subnet.conan_public_subnet.id
  route_table_id = aws_route_table.conan_public_rt.id
}


resource "aws_security_group" "conan_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.conan_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}


data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


resource "aws_key_pair" "conan_auth" {
  key_name   = "conan_key"
  public_key = file("~/.ssh/conankey.pub")
}


resource "aws_instance" "ec2_dev" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  vpc_security_group_ids = [aws_security_group.conan_sg.id]
  subnet_id              = aws_subnet.conan_public_subnet.id
  key_name               = aws_key_pair.conan_auth.id

  root_block_device {  
    volume_size = 20
  }
  tags = {
    Name = "dev-node"
  }
}




# EC2 Instance(s)
resource "aws_instance" "conanthedeployer" {
  count         = 3 # Create 3 instance(s)
  ami           = "ami-052efd3df9dad4825" # Ubuntu example, adjust as needed
  instance_type = "t2.micro" 

  tags = {
    Name = "conanthedeployer"
  }
}