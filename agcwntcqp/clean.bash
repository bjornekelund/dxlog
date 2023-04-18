#!/bin/bash
export LC_ALL=C

FILE=`ls AGCW-NTC*[0-9].txt | tail -1 2> /dev/null`
OUTFILE=AGCW-NTCQP-CLEANED.txt

echo Cleaning $FILE
dos2unix -q $FILE

gawk -f clean.awk $FILE > $OUTFILE

echo Created $OUTFILE
#unix2dos -q $OUTFILE

exit
