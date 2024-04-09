# Description: This file contains the variables for the security_group
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/security_group/variables.tf


# Define the variable for the VPC ID
variable "vpc_id" {
  # Importing from modules/vpc/outputs.tf
  type = string
}
