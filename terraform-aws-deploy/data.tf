
# Load ansible inventory file using template file
data "template_file" "inventory" {
  template = file("ansible/conan_project/inventory/inventory.tpl")

  vars = {
    instance_public_ip = aws_instance.conan_the_deployer.public_ip
  }
}

data "template_file" "group_vars_all" {
  template = file("ansible/conan_project/inventory/group_vars/all.tpl")

  vars = {
    ansible_ec2_user = var.ansible_ec2_user
    ansible_ssh_private_key_file = var.conan_private_key_filename
  }
}