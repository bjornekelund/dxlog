#!/bin/bash
FILE=`ls CVADXCW*.txt | tail -1 2> /dev/null`
OUTFILE=CVADX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | sed 's/ //g' | gawk -f cvadx.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
