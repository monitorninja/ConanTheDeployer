# Create a VPC to launch our instances into
resource "aws_vpc" "conan_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "conan_vpc" 
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

# Create a private subnet
resource "aws_subnet" "conan_default_private_subnet" {
  vpc_id     = aws_vpc.conan_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "conan_default_private_subnet"
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

# Explicitly associate the main route table with the subnet
resource "aws_route_table_association" "conan_route_table_association_a" {
  subnet_id      = aws_subnet.conan_default_public_subnet.id
  route_table_id = aws_route_table.conan_route_table_default.id
}