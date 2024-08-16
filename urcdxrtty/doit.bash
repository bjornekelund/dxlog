#!/bin/bash
FILE=`ls URC_D* | tail -1 2> /dev/null`
OUTFILE=URCDXRTTY_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f urcdxrtty.awk $FILE | sort | sed 's/^#./#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
