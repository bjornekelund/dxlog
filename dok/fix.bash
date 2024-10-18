#!/bin/bash
FILE=`ls WA* | tail -1 2> /dev/null`
OUTFILE=1WAG.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f fix.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
