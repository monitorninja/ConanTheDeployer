# Description: This file contains the outputs for the security_group
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/security_group/outputs.tf



# Export the AWS security group ID for allow_http
output "aws_security_group_allow_http_name" {
  value = aws_security_group.conanthedeployer_allow_http_sg.name
}

