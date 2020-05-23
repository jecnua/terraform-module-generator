#!/bin/bash
# Source: https://github.com/jecnua/terraform-module-generator
# Owner: jecnua <fabrizio.sabatini.it@gmail.com>
# License: MIT
# Usage:
# ./add_module.sh <root_dir> <module name>
# Example:
# ./add_module.sh terraform-aws-elasticsearch elasticsearch

# Check dependencies
if ! hash terraform-docs 2>/dev/null; then
    echo "You don't have terraform-docs installed. Please check README."
    echo "Exit"
    exit 1
fi

if [ "$#" -ne 2 ]; then
    echo "You need to specify 2 parameters."
    echo "Syntax add_module.sh <base_dir> <name>"
    exit 1
fi

MODULE_NAME="$2"


cd "$1" || exit

cd examples || exit

cat << EOF > main.tf
provider "aws" {
  version = "~> 2.63"
  region  = "eu-west-1"
}

module "test" {
  providers = {
    aws = aws
  }
  source         = "../modules/$MODULE_NAME"
  network_region = "eu-west-1"
}
EOF

cd .. || exit

cd modules || exit
mkdir "$MODULE_NAME"
cd "$MODULE_NAME" || exit

touch 'CHANGELOG.md'

# mkdir 'graphs'
# touch 'graphs/.gitignore'
mkdir 'scripts'
touch 'scripts/.gitignore'

# Create some empty file to help conventions
touch '00-variables_defaults.tf'
touch '00-variables_required_inputs.tf'
touch '01-ami.tf'
touch '02-network.tf'
touch '03-ec2.tf'
touch '04-role.tf'
touch '05-sns_and_notifications.tf'
touch '99-outputs.tf'

cat << 'EOF' > 00-backends_and_providers.tf
provider "aws" {
  region     = var.network_region
}
EOF

cat << EOF > 00-variables_required_inputs.tf
variable "network_region" {
  type        = string
  description = "The AWS region you want to work on"
}
EOF

rm -fr graphs/*
terraform init
terraform get

# Removed the graph since is a bad idea after all
# terraform graph > graphs/overview.dot
# dot -Tpng -o graphs/overview.png graphs/overview.dot
# echo "graph generated"

terraform-docs md "$(pwd)" >> "$(pwd)"/params.md

cat << 'EOF' > README.md
# Module

## Parameters

You can find them [here](params.md)

EOF

echo "Module added. Don't forget to git init and commit :)"
