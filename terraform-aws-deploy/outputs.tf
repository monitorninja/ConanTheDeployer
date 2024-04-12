# Description: This file contains the outputs for the main.tf file
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# ./outputs.tf

# Public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.conan_the_deployer.public_ip
}

# Public SSH key pair name
output "key_name" {
  value = aws_key_pair.deployer.key_name
}

# Secret ARN for the deploy key secret.  The value is a placeholder and will be replaced with the actual ARN automatically 
 # during deployment.
output "secret_arn" {
  value = "arn:aws:secretsmanager:us-east-1:ACCOUNT-ID:secret:deploy-key-name" 
}

output "ssh_command" {
  value = "ssh -i ${aws_secretsmanager_secret_version.key.arn} ec2-user@${aws_instance.example.public_ip}"
}

output "instance_ips" {
  value = aws_instance.example[*].private_ip
}

output "instance_names" {
  value = aws_instance.example[*].tags.Name
}
