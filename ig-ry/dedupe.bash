#!/bin/bash

OUTFILE=SCRY_2024-900.txt
NEW=`ls SCRY_2024-0* | tail -1 2> /dev/null`
FILE="BIG-IG_WW_RTTY.txt $NEW"

echo Parsing $FILE
dos2unix -q $FILE

echo "!!Order!!,Call,Exch1,UserText" > $OUTFILE
cat $FILE | gawk -f dedupe.awk | sort | sed 's/^\#. /\# /g' >> $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
