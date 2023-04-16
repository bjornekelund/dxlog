#!/bin/bash
FILE=`ls Gc* | tail -1 2> /dev/null`
OUTFILE=GAGARIN_KUP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f gagarin.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
