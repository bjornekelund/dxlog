#!/bin/bash
FILE=`ls PACC-* | tail -1 2> /dev/null`
OUTFILE=PACC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f pacc.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
