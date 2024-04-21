# AWS CDK
mkdir aws-cdk
cdk init
source aws-cdk/.venv/bin/activate
pip install -r aws-cdk/requirements.txt


# Python environment

ConanTheDeployer/venv/bin/python  # python binary for workspace venv
ConanTheDeployer/venv/bin/python -m pip install constructs

# Terminal in vsCode
source ConanTheDeployer/.venv/bin/activate


# Terraform
https://cloudkatha.com/how-to-create-key-pair-in-aws-using-terraform-in-right-way/


# Ansible
Ansible inventory template file is defined and configured in the terraform-aws-deploy/data.tf file where the ec2 public IP address
is passed as a variable to the template file.  Then, in terraform-aws-deploy/main.tf, we 'render' the inventory.ini file from that template. The "instance_public_ip" variable in the inventory.tpl file is defined in the terraform-aws-deploy/data.tf file.

pip install ansible-dev-tools
pip install ansible
pip install ansible-creator

ansible-creator init --project=ansible-project --scm-org=devops --scm-project=ConanTheDeployer --init-path /Users/cameo/development/vsCode_workspaces/ConanTheDeployer/terraform-aws-deploy/ansible/conan_project

ansible all -i terraform-aws-deploy/ansible/conan_project/inventory/inventory.ini -m ansible.builtin.ping

# minikube/kubernetes
minikube start
😄  minikube v1.30.1 on Darwin 14.3.1
🎉  minikube 1.32.0 is available! Download it: https://github.com/kubernetes/minikube/releases/tag/v1.32.0
💡  To disable this notice, run: 'minikube config set WantUpdateNotification false'

✨  Automatically selected the docker driver. Other choices: virtualbox, ssh
📌  Using Docker Desktop driver with root privileges
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
💾  Downloading Kubernetes v1.26.3 preload ...