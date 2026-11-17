#!/bin/bash
export LANG=C.UTF8

DOWNLOADS="agb agcw agcwntcqp cqmm dig euhfc foc hsc mcdqp podxs rcwc fistsspr bccqp"

for contest in $DOWNLOADS; do
  echo -------- $contest
  cd $contest
  # pwd
  ./doit.sh $1
  cd ..
done

exit
