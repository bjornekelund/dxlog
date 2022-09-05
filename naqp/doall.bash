#!/bin/bash
FOLDER="`pwd`/derivatives"
echo $FOLDER
LIST="coqp hiqp iaqp ksqp laqp msqp mtqp ndqp nhqp njqp vtqp"
test -e "$FOLDER" || mkdir $FOLDER
rm -f $FOLDER/*

for contest in $LIST; do
  cd ../$contest
  echo "Doing" $contest
  ./doit.bash &> log.txt
  cp *_db.txt $FOLDER
#  echo $contest
done

exit
