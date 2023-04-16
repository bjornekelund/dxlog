#!/bin/bash
FILE=`ls CME* | tail -1 2> /dev/null`
OUTFILE=EACME_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f eacme.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
