#!/bin/bash
FILE=`ls ALLASIACW_* | tail -1 2> /dev/null`
OUTFILE=ALLASIAN_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f allasian.awk $FILE | sort | sed 's/^#[0-9]/#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
