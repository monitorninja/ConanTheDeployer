# Description: This file contains the configuration for the variables file.  We DEFINE variables here, however we SET variables with a .tfvars file, environment variables, or the '-var' command line option when running Terraform.
  #   Key points:
  #   variables.tf declares variables (type, description, defaults) [2]
  #   .tfvars assigns values to variables
  #   .tfvars avoids checking sensitive values into source control
  #   Default values can be set in variables.tf if needed [3]
  #   Variables without defaults require values set in .tfvars
#
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# ./variables.tf

# Declare the public IP variable of the EC2 instance
variable "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  type = string
  default = "0.0.0.0"
}

# Declare the ansible ec2 user for ansible connection to the EC2 instance.  Variable set in 'terraform.tfvars' file in this same directory
variable "ansible_ec2_user" {
  description = "value of the ansible_ec2_user variable"
  type = string
  default = "ec2-user"
}

# variable "conan_private_key" {
#   # This variable declared here, but set in the terraform.tfvars file in this same directory
#   description = "Cannot use file() function in variables.tf file. Set the value of this variable later via a .tfvars file, environment variables, or the '-var' command line option when running Terraform"
#   type = string
#   default = "~/.ssh/conankey.private"
# }

variable "conan_private_key_filename" {
  # This variable declared here, but set in the terraform.tfvars file in this same directory
  description = "Cannot use file() function in variables.tf file. Set the value of this variable later via a .tfvars file, environment variables, or the '-var' command line option when running Terraform"
  type = string
  default = "terraform-aws-deploy/.ssh/conan_private_key_terraform_output.pem"
}

# Declare the SSH command variable to the user
variable "ssh_command" {
  description = "SSH command string for the EC2 instance"
  type = string
  default = "ssh"
}

/*
variable "conan_vpc_id" {
  
}
*/