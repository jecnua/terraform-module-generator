#!/bin/bash

MODULE_DIR="tf-$1-$2"

mkdir $MODULE_DIR
cd $MODULE_DIR || exit
mkdir 'examples'
mkdir 'modules'
mkdir 'test'
touch '.gitignore'
echo '**.DS_Store' >> .gitignore
touch 'README.md'
echo "# $MODULE_DIR" >> 'README.md'
