# Description: This file contains the configuration for the main Terraform deployment
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# main.tf


# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "conan_vpc" 
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "conan_internet_gateway"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "conan_route_table"
  }
}

# Create a public subnet to launch our instances into 
resource "aws_subnet" "default_public" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "conan_subnet"
  }
}

# Explicitly associate the main route table with the subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.default_public.id
  route_table_id = aws_route_table.default.id
}

# Create key pair for SSH access to our instances
resource "aws_key_pair" "deployer" {
  key_name   = "conan_the_deployer-key"
  public_key = var.public_key
  provisioner "local-exec" {
    command = "aws secretsmanager create-secret --name conan_the_deployer-key --secret-string fileb://path/to/public/key.pub" 
  }
}

# Create a security group for the EC2 instance
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}


# Launch an EC2 instance
resource "aws_instance" "conan_the_deployer" {
  ami           = "ami-0c02fb55956c7d316" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.default_public.id

  security_groups = [
    aws_security_group.allow_web.name
  ]
  tags = {
    Name = "conan_the_deployer"
  }

  key_name = "${output.secret_arn}"
}


