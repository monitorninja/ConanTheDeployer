# Description: This file contains the outputs for the security_group
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/security_group/outputs.tf



# Export the AWS security group name for allow_http
output "aws_sg_allow_http_name" {
  value = [aws_security_group.conanthedeployer_allow_http_sg.name][0]
}

# modules/security_group/outputs.tf
output "security_group_id" {
  value = aws_security_group.conanthedeployer_allow_http_sg.id
}