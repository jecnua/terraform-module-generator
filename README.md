# Terraform module generator

This repo contains script to:

- Generate a new github module repo following terragrunt best practices
- Add a new module in an existing repo

## Requirements

- terraform
- [terraform-docs](https://github.com/segmentio/terraform-docs)

## Usage

### Create a new repo

    ./create_repo.sh aws elasticsearch

### Add a module to a repo

    ./add_repo.sh elasticsearch
