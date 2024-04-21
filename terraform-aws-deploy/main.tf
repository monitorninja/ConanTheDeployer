# Description: This file contains the configuration for the main Terraform deployment
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# main.tf
/*
# Create a VPC to launch our instances into
resource "aws_vpc" "conan_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "conan_vpc" 
  }
}
*/

module "conan_vpc_module" {
  source = "./modules/vpc_subnets"
  // pass any required variables to the module...
}

# Create a security group for the EC2 instance to allow web traffic from anywhere and ssh traffic from the public internet
resource "aws_security_group" "allow_web_ssh_traffic" {
  name        = "allow_web_ssh_traffic"
  description = "Allow web and ssh traffic"
  vpc_id      = module.conan_vpc_module.conan_vpc_id

  depends_on = [module.conan_vpc_module.conan_vpc_id]

  # SSH access from anywhere
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["97.71.253.11/32"]
  }

  # HTTP access from anywhere
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
  }

  # HTTPS access from anywhere
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Ignore changes to the security group
  lifecycle {
    ignore_changes = [ingress]
  }

  # Add tags to the security group
  tags = {
    Name = "allow_web_ssh_traffic"
  }
}

# Create a private ssh key for the EC2 instance
resource "tls_private_key" "conan_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a key pair for the EC2 instance by creating a public key using the private key
resource "aws_key_pair" "conan_generated_key_pair" {
  key_name   = "conan_generated_key_pair"
  public_key = "${tls_private_key.conan_private_key.public_key_openssh}"
  tags = {
    Name = "conan_generated_key_pair"
  }
}

# Create a local file with the contents of conan_private_key in .pem format
resource "local_file" "conan_private_key_file" {
  filename = ".ssh/conan_private_key_terraform_output.pem"
  content  = tls_private_key.conan_private_key.private_key_pem
}

resource "null_resource" "change_file_permission" {
  depends_on = [local_file.conan_private_key_file]
  provisioner "local-exec" {
    command = "chmod 600 .ssh/conan_private_key_terraform_output.pem"
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}


# Launch an EC2 instance and assign to public subnet - this will indirectly attach this instance to the correct vpc because the vpc is already associated with the security group.
resource "aws_instance" "conan_the_deployer" {
  ami           = "ami-0c02fb55956c7d316" 
  # ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = module.conan_vpc_module.conan_public_subnet_id
  associate_public_ip_address = true

  key_name      = "${aws_key_pair.conan_generated_key_pair.key_name}"

  depends_on = [aws_security_group.allow_web_ssh_traffic]

  vpc_security_group_ids = [
    aws_security_group.allow_web_ssh_traffic.id
  ]
  
  tags = {
    Name = "conan_the_deployer"
  }

 user_data = <<EOF
  #!/bin/bash
  mkdir -p ~/.ssh
  echo "${aws_key_pair.conan_generated_key_pair.public_key}" > ~/.ssh/authorized_keys
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys
  EOF
}

# Populate ansible inventory.ini file with the public IP of the EC2 instance
resource "local_file" "inventory" {
  content  = data.template_file.inventory.rendered
  filename = "ansible/conan_project/inventory/inventory.ini"
  depends_on = [aws_instance.conan_the_deployer]
}

# Populate the ansible/conan_project/inventory/group_vars/all.yml with private ssh key
resource "local_file" "group_vars_all" {
  content  = data.template_file.group_vars_all.rendered
  filename = "ansible/conan_project/inventory/group_vars/all.yml"
  depends_on = [aws_instance.conan_the_deployer]
}