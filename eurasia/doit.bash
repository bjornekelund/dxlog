#!/bin/bash
FILE=`ls EUAS-CH* | tail -1 2> /dev/null`
OUTFILE=EURASIA_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f eurasia.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
