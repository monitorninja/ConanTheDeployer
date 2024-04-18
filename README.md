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
pip install ansible-dev-tools
pip install ansible
pip install ansible-creator

ansible-creator init --project=ansible-project --scm-org=devops --scm-project=ConanTheDeployer --init-path /Users/cameo/development/vsCode_workspaces/ConanTheDeployer/terraform-aws-deploy/ansible/conan_project


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