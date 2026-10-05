#!/bin/bash
if ../1helpers/download.sh NAQPCW || [ -n "$1" ]; then
  INFILE=`ls NAQPC* | tail -1 2> /dev/null`
  OUTFILE=NAQP_db.txt
  HELPERS=../1helpers/helpers.awk

  echo Parsing $INFILE
  dos2unix -q $INFILE

  sed 's/ //g' $INFILE | gawk -f $HELPERS -f naqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

  unix2dos -q $OUTFILE $INFILE
  echo Created $OUTFILE

  ../copytosourcetree.sh $OUTFILE

  LIST="mdqp mtqp"

  for contest in $LIST; do
    echo ---------------
    cd ../$contest
    echo "Doing" $contest "in" `pwd`
    ./doit.sh
  done
fi
exit
