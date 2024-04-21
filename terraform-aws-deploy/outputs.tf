# Description: This file contains the outputs for the main.tf file
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# ./outputs.tf

# Public IP address of the EC2 instance
output "ec2_public_ip" {
  value = aws_instance.conan_the_deployer.public_ip
}

/*
output "public_key" {
  value = aws_key_pair.conan_generated_key_pair.key_name
}
*/

output "conan_private_key_filename" {
  value = local_file.conan_private_key_file.filename
}

output "ssh_command" {
  value = "ssh -i ${local_file.conan_private_key_file.filename} ${var.ansible_ec2_user}@${aws_instance.conan_the_deployer.public_ip}"
}