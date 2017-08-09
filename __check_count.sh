#!/bin/bash
# This checks will check modules to check counts

N_SUCCESS=0
N_FAILED=0

RED='\033[0;31m'
NC='\033[0m' # No Color

# Check all modules
cd modules || exit 1
printf "Checking:\n"
for a_directory in `ls -d */`
do
  printf "\n== ENTER $a_directory ==\n"
  cd $a_directory || exit
  for b_directory in `ls -d */`
  do
    TOTAL=`find . -name "*.tf" | xargs cat | grep '== 0 ? 0 : 1' | wc -l`
    if [[ $TOTAL -ne 0 ]]
    then
      printf "$RED Failed! Found $TOTAL occurrence/s $NC \n"
      let N_FAILED=N_FAILED+1
    else
      echo "ALL GOOD"
      let N_SUCCESS=N_SUCCESS+1
    fi
  done
  cd ..
  printf "=====================\n\n"
done
echo "Success: "$N_SUCCESS
printf "$RED Failed: $N_FAILED $NC \n"

if [[ $N_FAILED -ne 0 ]]
then
  exit 1
else
  exit 0
fi
