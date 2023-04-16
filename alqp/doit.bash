#!/bin/bash
FILE=`ls QSOP_AL* | tail -1 2> /dev/null`
OUTFILE=AQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f alqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
