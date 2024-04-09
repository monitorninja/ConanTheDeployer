# Description: This file contains the queried data for the EC2 module
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/ec2/data.tf


# Create ec2 resource data object to fetch the public IP
data "aws_instance" "conanthedeployer" {
  depends_on = [aws_instance.conanthedeployer]
  instance_id = aws_instance.conanthedeployer.id
  public_ip = aws_instance.conanthedeployer.public_ip 
}