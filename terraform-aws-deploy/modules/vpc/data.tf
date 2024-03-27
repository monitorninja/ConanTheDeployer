# Description: This file contains fetches data for the vpc instance
# Author:      Frank Aaron Smith
# Date:        4/26/2024
# Version:     1.0

# modules/vpc/data.tf


data "aws_availability_zones" "available" {
  state = "available" # Ensure we fetch only active AZs
}
