#!/bin/bash
# Source: https://github.com/jecnua/terraform-module-generator
# Owner: jecnua <fabrizio.sabatini.it@gmail.com>
# License: MIT
# Usage:
# ./create_repo.sh <one> <two>
# Example:
# ./create_repo.sh aws elasticsearch

PREFIX="terraform"

if [ "$#" -ne 2 ]; then
    echo "You need to specify 2 parameters."
    echo "Syntax create_repo.sh aws elasticsearch"
    exit 1
fi

MODULE_DIR="$PREFIX-$1-$2"

mkdir "$MODULE_DIR"
cd "$MODULE_DIR" || exit
mkdir 'examples'
touch 'examples/.gitignore'
mkdir 'modules'
touch 'modules/.gitignore'
mkdir 'test'
touch 'test/.gitignore'
touch '.gitignore'
mkdir -pr '.github/workflows'
touch 'tests.yaml'

cat << EOF > .github/workflows/tests.yaml
name: tests
# This workflow is triggered on pushes to the repository.
on: [push]

jobs:
  default:
    name: default
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: list
        run: |
          ls -la
          pwd

  shellcheck:
    name: shellchecks
    runs-on: ubuntu-latest
    container:
      image: ubuntu:20.04
      env:
        placeholder: test
    steps:
        - uses: actions/checkout@v2
        - name: Install deps
          run: |
            # Install deps
            apt update
            DEBIAN_FRONTEND=noninteractive apt install -y shellcheck
        - name: Shellcheck
          run: |
            shellcheck *.sh # Validating BASH

  # https://github.com/hashicorp/setup-terraform
  tfcheckmodules:
    name: terraform checks modules
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: hashicorp/setup-terraform@v1
      with:
        terraform_version: 0.12.29
    - run: |
        cd modules/xyz/
        terraform init
        terraform fmt -check
EOF


cat << EOF > .gitignore
# Terraform files
.idea
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

[![Actions Status](https://github.com/xyz/xyz/workflows/tests/badge.svg)](https://github.com/xyz/xyz/actions)
![](https://img.shields.io/maintenance/yes/2020.svg)
![https://www.terraform.io/](https://img.shields.io/badge/terraform-v0.13.x-blue.svg?style=flat)

## Quick links

- [Module maintainers](MAINTAINERS.md)

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

echo "Repo created. Don't forget to:"
echo "- add the maintainer"
echo "- change the path in the github actions label in the README"
echo "- change the path in the github actions yaml"
echo "- git init and commit :)"
