#!/bin/bash
FILE=`ls POTA-* | tail -1 2> /dev/null`
OUTFILE=POTA_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f pota.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
