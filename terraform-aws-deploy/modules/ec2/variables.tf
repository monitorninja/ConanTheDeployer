# Description: This file contains the variables for the EC2 instance(s)
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/ec2/variables.tf


# Define the variable for the VPC ID
variable "aws_security_group_allow_http_name" {
  # Importing from modules/security_group/outputs.tf
  type = string
}
