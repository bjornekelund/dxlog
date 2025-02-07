#!/bin/bash
FILE=`ls RDAC_2* | tail -1 2> /dev/null`
OUTFILE=RDAC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f rdac.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
