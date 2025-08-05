#!/bin/bash

LIST="naqp mdqp mtqp"

for contest in $LIST; do
  cd ../$contest
  echo "Doing" $contest "in" `pwd`
  ./doit.bash
  echo ---------------
done

exit
