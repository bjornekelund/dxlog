#!/bin/bash
FILE=`ls 13COLONIES-* | tail -1 2> /dev/null`
OUTFILE=13COLONIES_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f 13colonies.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
