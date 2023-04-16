#!/bin/bash
FILE=`ls QSOP_LA* | tail -1 2> /dev/null`
OUTFILE=LAQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f laqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
