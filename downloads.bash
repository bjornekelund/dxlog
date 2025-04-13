#!/bin/bash

DOWNLOADS="agb agcw foc hsc dig mcdqp jidxc"

echo $DOWNLOADS

for contest in $DOWNLOADS; do
  echo doing $contest
  pwd
  cd $contest
  ./doit.bash
  cd ..
done

cd bccqp
./regex-doit.bash
cd ..


exit
