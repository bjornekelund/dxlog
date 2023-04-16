#!/bin/bash
FILE=`ls A1AWT* | tail -1 2> /dev/null`
OUTFILE=A1CWC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f a1cwc.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
