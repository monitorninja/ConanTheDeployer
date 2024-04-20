
# Load ansible inventory file using template file
data "template_file" "inventory" {
  template = file("ansible/conan_project/inventory/inventory.tpl")

  vars = {
    instance_public_ip = aws_instance.conan_the_deployer.public_ip
  }
}