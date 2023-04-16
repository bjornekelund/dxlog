#!/bin/bash
FILE=`ls YUDXC* | tail -1 2> /dev/null`
OUTFILE=YUDX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f yudx.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
