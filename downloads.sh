#!/bin/bash

DOWNLOADS="agb agcw cqmm dig euhfc foc hsc mcdqp podxs rcwc fistsspr arrlrr agcwntcqp"

for contest in $DOWNLOADS; do
  echo -------- $contest
  cd $contest
  pwd
  ./doit.sh
  cd ..
done

echo -------- bccqp
cd bccqp
./regex-doit.sh
./updatecontestdefinition.sh
cd ..

exit
