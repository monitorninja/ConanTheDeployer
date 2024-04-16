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


# Ansible
pip install ansible-dev-tools
pip install ansible
pip install ansible-creator

ansible-creator init --project=ansible-project --scm-org=devops --scm-project=ConanTheDeployer --init-path /Users/cameo/development/vsCode_workspaces/ConanTheDeployer/terraform-aws-deploy/ansible/conan_project