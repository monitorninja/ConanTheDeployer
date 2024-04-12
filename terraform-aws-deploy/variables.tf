# Description: This file contains the configuration for the variables file
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# ./variables.tf

# Import the public IP variable of the EC2 instance
variable "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  type = string
  default = "0.0.0.0"
}

# Import the SSH command variable to the user
variable "ssh_command" {
  description = "SSH command string for the EC2 instance"
  type = string
    default = "ssh"
}
