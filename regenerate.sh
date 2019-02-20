#!/bin/bash
# Source: https://github.com/jecnua/terraform-module-generator
# Owner: jecnua <fabrizio.sabatini.it@gmail.com>
# License: MIT
# Usage:
# ./regenerate.sh

RED='\033[0;31m'
NC='\033[0m' # No Color

cd modules || exit
for a_directory in `ls -d */`
do
  (
  cd $a_directory || exit
  # if [ ! -d "graphs" ]; then
  #   echo "Dir graphs not present. Creating..."
  #   mkdir graphs
  # fi
  if [ ! -f "README.md" ]; then
    touch README.md
  fi
  # echo $a_directory
  dir_name=`echo $a_directory | sed 's:/*$::'`
  # echo $dir_name
  # terraform validate &> /dev/null
  RESULT=$?
  if [ $RESULT -eq 0 ]; then
    # rm -fr graphs/*
    terraform init
    terraform get
    # terraform graph > graphs/overview.dot
    # dot -Tpng -o graphs/overview.png graphs/overview.dot
    # echo "$dir_name: graph regenerated"
  else
    printf "$RED $dir_name: terraform validate failed. $NC \n"
  fi
  terraform-docs md "`pwd`" > "`pwd`"/params.md
  echo "$dir_name: params regenerated"
  )
done
