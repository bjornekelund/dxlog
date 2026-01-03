#!/bin/bash
INFILE=`ls NTC_QP* | tail -1 2> /dev/null`
OUTFILE=NTC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

tr -d ' ' < $INFILE | gawk -f ntc.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
