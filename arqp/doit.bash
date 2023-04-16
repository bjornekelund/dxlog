#!/bin/bash
FILE=`ls QSOP_AR* | tail -1 2> /dev/null`
OUTFILE=ARQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f arqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
