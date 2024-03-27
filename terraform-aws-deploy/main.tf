# Description: This file contains the configuration for the main Terraform deployment
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# main.tf

module "vpc" {
    source = "./modules/vpc"
}

module "security_group" {
    source = "./modules/security_group"
    vpc_id = module.vpc.vpc_id
}

module "ec2" {
    source = "./modules/ec2"
    aws_security_group_allow_http_name = module.security_group.aws_security_group_allow_http_name
    public_subnet_id = module.vpc.aws_subnet_public_id
}

module "s3" {
    source = "./modules/s3"
}

module "ssh" {
    source = "./modules/ssh"
}

# Add more modules here if needed

