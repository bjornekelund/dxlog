#!/bin/bash
FILE=`ls QSOP_FL* | tail -1 2> /dev/null`
OUTFILE=FLQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f flqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
