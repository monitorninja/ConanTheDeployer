# Description: This file contains the outputs for the EC2 module
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/ec2/outputs.tf

# Export the public IP of the EC2 instance
output "ec2_public_ip" {
  value = data.aws_instance.conanthedeployer.public_ip
}

# Export the SSH command to the user
output "ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa.pub ec2-user@${data.aws_instance.conanthedeployer.public_ip}"
}
