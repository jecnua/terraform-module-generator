#!/bin/bash
# Source: https://github.com/jecnua/terraform-module-generator
# Owner: jecnua <fabrizio.sabatini.it@gmail.com>
# License: MIT
# Usage:
# ./create_repo.sh <one> <two>
# Example:
# ./create_repo.sh aws elasticsearch

MODULE_DIR="tf-$1-$2"

mkdir $MODULE_DIR
cd $MODULE_DIR || exit
mkdir 'examples'
touch 'examples/.gitignore'
mkdir 'modules'
touch 'modules/.gitignore'
mkdir 'test'
touch 'test/.gitignore'
touch '.gitignore'

cat << EOF > .gitignore
# Terraform files
.terraform
terraform.tfstate
terraform.tfvars
*.tfstate*

# OS X files
.history
.DS_Store
EOF

touch 'README.md'
echo "# $MODULE_DIR" >> 'README.md'

echo "Repo created. Don't forget to git init and commit :)"
