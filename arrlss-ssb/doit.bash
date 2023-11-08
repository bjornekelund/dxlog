#!/bin/bash
FILE=`ls SS* | tail -1 2> /dev/null`

OUTFILE1=ARRL_SS_db.txt
OUTFILE2=ARRL_SS_SSB_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f arrlss.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE1

sed 's/ARRL CW/ARRL SSB/g' $OUTFILE1 > $OUTFILE2

echo Created $OUTFILE1 and $OUTFILE2
unix2dos -q $OUTFILE1 $OUTFILE2

exit
