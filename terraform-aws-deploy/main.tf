# Description: This file contains the configuration for the main Terraform deployment
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# main.tf


# Create a VPC to launch our instances into
resource "aws_vpc" "conan_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "conan_vpc" 
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "conan_internet_gateway" {
  vpc_id = aws_vpc.conan_vpc.id

  tags = {
    Name = "conan_internet_gateway"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route_table" "conan_route_table_default" {
  vpc_id = aws_vpc.conan_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.conan_internet_gateway.id
  }

  tags = {
    Name = "conan_route_table_default"
  }
}

# Create a public subnet to launch our instances into 
resource "aws_subnet" "conan_default_public_subnet" {
  vpc_id     = aws_vpc.conan_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "conan_default_public_subnet"
  }
}

# Explicitly associate the main route table with the subnet
resource "aws_route_table_association" "conan_route_table_association_a" {
  subnet_id      = aws_subnet.conan_default_public_subnet.id
  route_table_id = aws_route_table.conan_route_table_default.id
}


resource "tls_private_key" "conan_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "conan_generated_public_key" {
  key_name   = "${var.conan_private_key}"
  public_key = "${tls_private_key.conan_private_key.public_key_openssh}"
}

# Create a local file with the contents of conan_private_key
resource "local_file" "conan_private_key_file" {
  filename = "~/.ssh/conan_private_key_terraform_output.pem"
  content  = tls_private_key.conan_private_key.private_key_pem
}

/*
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
*/

# Create a security group for the EC2 instance
resource "aws_security_group" "allow_web_ssh_traffic" {
  name        = "allow_web_ssh_traffic"
  description = "Allow web and ssh traffic"
  vpc_id      = aws_vpc.conan_vpc.id

  # SSH access from anywhere
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
  }

  # HTTPS access from anywhere
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Ignore changes to the security group
  lifecycle {
    ignore_changes = [ingress]
  }

  # Add tags to the security group
  tags = {
    Name = "allow_web_ssh_traffic"
  }
}

# Launch an EC2 instance
resource "aws_instance" "conan_the_deployer" {
  ami           = "ami-0c02fb55956c7d316" 
  # ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.conan_default_public_subnet.id
  key_name      = "${aws_key_pair.conan_generated_public_key.key_name}"

  security_groups = [
    aws_security_group.allow_web_ssh_traffic.name
  ]
  tags = {
    Name = "conan_the_deployer"
  }

#  user_data = <<EOF
# #!/bin/bash
# mkdir -p ~/.ssh
# echo "${var.public_key}" > ~/.ssh/authorized_keys
# chmod 600 ~/.ssh/authorized_keys
# EOF

}


