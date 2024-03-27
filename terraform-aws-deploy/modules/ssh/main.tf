# Description: This file contains the configuration for the SSH
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/ssh/main.tf

# Key Pair
resource "aws_key_pair" "frankaaronsmith-web-server_key" {
  key_name   = "frankaaronsmith-web-server-ssh-terraform-key"
  public_key = file("~/.ssh/id_rsa.pub") # This is the path to your current local public ssh key
}
#Add the following to the ec2 resource definition block:
#   key_name  = aws_key_pair.app_server_key.key_name

