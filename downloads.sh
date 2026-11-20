#!/bin/bash
export LANG=C.UTF8

DOWNLOADS="agb agcw agcwntcqp bccqp cqmm dig epc euhfc fistsspr foc hsc mcdqp podxs rcwc"

for contest in $DOWNLOADS; do
  # echo -------- $contest
  cd $contest
  # pwd
  ./doit.sh $1
  cd ..
done

exit 0
