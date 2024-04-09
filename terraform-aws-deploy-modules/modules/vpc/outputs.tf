# Description: This file contains the output for the vpc instance(s)
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/vpc/outputs.tf


# Export the VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

# Export the public aws_subnet_public ID
output "aws_subnet_public_id" {
  value = aws_subnet.public.id
}