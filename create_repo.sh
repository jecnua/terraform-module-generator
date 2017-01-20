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

# Add README
echo "# $MODULE_DIR

![https://www.terraform.io/](https://img.shields.io/badge/terraform-v0.8.0-blue.svg?style=flat)

## Maintainers

[Module maintainers](MAINTAINERS.md)
" > README.md

# Add Maintainers file
echo '# Maintainers

| Role | Name | Email |
|------|------|:-------------:|
| Primary | X | X |
| Secondary | Y | Y |
' > MAINTAINERS.md

# Pull regenerate script
wget https://raw.githubusercontent.com/jecnua/terraform-module-generator/master/regenerate.sh
chmod 700 regenerate.sh

echo "Repo created. Don't forget to git init and commit :)"
