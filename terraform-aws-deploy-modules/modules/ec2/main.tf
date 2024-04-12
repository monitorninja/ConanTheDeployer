# Description: This file contains the configuration for the EC2 instance(s)
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/ec2/main.tf

# Terraform version
terraform {
  required_version = ">= 1.0.0"
}

## AWS Provider
#provider "aws" {
#  region = "us-east-1"
#}

# EC2 Instance(s)
resource "aws_instance" "conanthedeployer" {
  count         = 1 # Create 1 instance
  ami           = "ami-052efd3df9dad4825" # Ubuntu example, adjust as needed
  instance_type = "t2.micro" 

  # Attach public subnet to EC2 instance
  subnet_id     = var.public_subnet_id

  # Attach Security Group to EC2 instance
  # security_groups = [var.aws_sg_allow_http_name]

  network_interface {
    device_index = 0
    network_interface_id =     .main.id
    # associate_public_ip_address = true 
  }

  tags = {
    Name = "conanthedeployer"
  }
}
