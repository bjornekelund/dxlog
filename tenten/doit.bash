#!/bin/bash
FILE=`ls 1010* | tail -1 2> /dev/null`
OUTFILE=TENTEN_db.txt

echo Parsing $FILE
dos2unix -q $FILE

sed 's/ //g' $FILE | gawk -f tenten.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit
