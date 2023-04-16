#!/bin/bash
FILE=`ls PCC_[MN]* | tail -1 2> /dev/null`
OUTFILE=PCC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f pcc.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
