
output "conan_vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.conan_vpc.id  # Replace with your actual VPC resource
}

output "conan_private_subnet_id" {
    description = "The ID of the private subnet"
    value       = aws_subnet.conan_default_private_subnet.id 

}

output "conan_public_subnet_id" {
    description = "The ID of the public subnet"
    value       = aws_subnet.conan_default_public_subnet.id 

}
