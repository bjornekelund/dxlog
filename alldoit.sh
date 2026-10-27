#!/bin/bash
ALL=$(ls | grep '^[a-z]')

for contest in $ALL; do
  if [ -d $contest ] && [ -f $contest/doit.sh ]; then
    echo -------- $contest
    cd $contest
    ./doit.sh
    cd ..
  fi
done

exit 0
