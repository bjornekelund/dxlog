#!/bin/bash
FILE=`ls NTC_QP* | tail -1 2> /dev/null`
OUTFILE=NTC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

tr -d ' ' < $FILE | gawk -f ntc.awk | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
