# Description: This file contains the configuration for the security_group
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/security_group/main.tf


resource "aws_security_group" "conanthedeployer_allow_http_sg" {
  name        = "allow_http_sg"
  description = "Allow HTTP and HTTPS traffic to demo webserver"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP (port 80)" 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    description = "HTTPS (port 443)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # (Optional) Ingress for SSH (port 22) from your IP - adjust as needed
  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["your_home_ip_address/32"]  # Example
  # }

  egress {
    from_port   = 0  # Allow all outbound traffic
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_sg"
  }
}

# create a security group for the 
