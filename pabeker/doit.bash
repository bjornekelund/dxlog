#!/bin/bash
FILE=`ls PABEKER[^_]* | tail -1 2> /dev/null`
OUTFILE=PABEKER_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f pabeker.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
