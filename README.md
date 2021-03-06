# Terraform module generator

[![Actions Status](https://github.com/jecnua/terraform-module-generator/workflows/tests/badge.svg)](https://github.com/jecnua/terraform-module-generator/actions)
![](https://img.shields.io/maintenance/yes/2020.svg)

This repo contains scripts to:

-   Generate a new github module repo following terragrunt best practices
-   Add a new module in an existing repo

## Maintainers

-   [Module maintainers](MAINTAINERS.md)

## Requirements

-   terraform
-   [terraform-docs](https://github.com/segmentio/terraform-docs)

## Usage

### Pull this repository

    git clone git@github.com:jecnua/terraform-module-generator.git

### Create a new repo

There is no need to enter in the repo dir. Just use the script from the location
you want to create the repo:

    terraform-module-generator/create_repo.sh <one> <two>

Will create a repo called terraform-one-two.
So, for example:

    terraform-module-generator/create_repo.sh aws elasticsearch

Will create a module called terraform-aws-elasticsearch.

### Add a module to a repo

    terraform-module-generator/add_module.sh <base_dir> <name>

Will add a module inside the modules directory of the <name> dir.
So, for example:

    terraform-module-generator/add_module.sh terraform-aws-elasticsearch elasticsearch

Will add a dir called elasticsearch inside the terraform-aws-elasticsearch dir.
It will also generate the params.md file and the graph. All is linked from a
README.md created in the module directory.

Remember to change the directory the github actions will run test on

## License

Don't forget to add the license if it's a public repository. :)

## TODO

- Add text in the CHANGELOG
