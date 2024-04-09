# Description: This file contains the outputs for the main.tf file
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# ./outputs.tf

output "ec2_public_ip" {
  value = var.ec2_public_ip
}

# Import the SSH command variable to the user
output "ssh_command" {
  value = var.ssh_command
}
