#!/bin/bash
FILE=`ls SRR* | tail -1 2> /dev/null`
OUTFILE=SRR-CUP-DIGI_db.txt

echo Parsing $FILE
dos2unix $FILE

gawk -f srr-cup-digi.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
