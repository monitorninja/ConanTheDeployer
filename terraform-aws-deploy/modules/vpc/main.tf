# Description: This file contains the VPC configuration
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/vpc/main.tf

# VPC create
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "conanthedeployer-web-server-terraform-vpc"
  }
}

# Subnet (add a public subnet within the VPC)
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24" 
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "conanthedeployer-web-server-public-subnet"
  }

  #depends_on = [module.vpc]  # depends on VPC creation first
}

# Internet Gateway (To allow internet access for our instances)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "conanthedeployer-web-server-terraform-igw"
  }
}

# Route Table & Association 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "conanthedeployer-web-server-public-rt"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group (Allow HTTP access for now)
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic to EC2 instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP (port 80)" 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0  
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

