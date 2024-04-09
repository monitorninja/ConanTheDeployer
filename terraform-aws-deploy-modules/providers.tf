# Description: This file contains the configuration for the providers
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  
}