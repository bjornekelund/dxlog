#!/bin/bash

DOWNLOADS="agb agcw cqmm dig euhfc foc hsc mcdqp"

for contest in $DOWNLOADS; do
  echo -------- $contest
  cd $contest
  pwd
  ./doit.bash
  cd ..
done

echo -------- bccqp
cd bccqp
./regex-doit.bash
./updatecontestdefinition.bash
cd ..

exit
