#!/bin/bash
FILE=`ls UKEI80_V* | tail -1 2> /dev/null`
OUTFILE=UKEI80_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ukeicc.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
