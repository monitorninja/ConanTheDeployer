# Description: This file contains the variables for the EC2 instance(s)
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/ec2/variables.tf


# Define the variable for the VPC ID
variable "aws_sg_allow_http_id" {
  # Importing from modules/security_group/outputs.tf
  type = list(string)
}

# Define the variable for the public subnet ID
variable "public_subnet_id" {
  type = string
}

# Define the variable for the VPC ID
variable "vpc_id" {
  # Importing from modules/vpc/outputs.tf
  type = string
}