#!/bin/bash
# Source: https://github.com/jecnua/terraform-module-generator
# Owner: jecnua <fabrizio.sabatini.it@gmail.com>
# License: MIT
# Usage:
# ./add_module.sh <root_dir> <module name>
# Example:
# ./add_module.sh tf-aws-elasticsearch elasticsearch

# Check dependencies
if ! hash terraform-docs 2>/dev/null; then
    echo "You don't have terraform-docs installed. Please check README."
    echo "Exit"
    exit 1
fi

MODULE_NAME="$2"

cd $1 || exit
cd modules || exit
mkdir $MODULE_NAME
cd $MODULE_NAME || exit

touch 'CHANGELOG.md'

mkdir 'graphs'
touch 'graphs/.gitignore'
mkdir 'scripts'
touch 'scripts/.gitignore'

# Create some empty file to help conventions
touch '00-variables_defaults.tf'
touch '01-main.tf'

cat << 'EOF' > 00-provider.tf
provider "aws" {
  region     = "${var.network_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
EOF

cat << EOF > 00-variables_required_inputs.tf
variable "access_key" {
  type        = "string"
  description = "Your AWS access key"
}

variable "secret_key" {
  type        = "string"
  description = "Your AWS secret token"
}

variable "network_region" {
  type        = "string"
  description = "The AWS region you want to work on"
}
EOF

touch '99-outputs.tf'

rm -fr graphs/*
terraform init
terraform get
terraform graph > graphs/overview.dot
dot -Tpng -o graphs/overview.png graphs/overview.dot
echo "graph generated"

terraform-docs md "`pwd`" >> "`pwd`"/params.md

cat << 'EOF' > README.md
# Module
![Overview](graphs/overview.png)

## Parameters

You can find them [here](params.md)

EOF

echo "Module added. Don't forget to git init and commit :)"
