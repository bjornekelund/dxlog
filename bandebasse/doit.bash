#!/bin/bash
FILE=`ls BB_* | tail -1 2> /dev/null`
OUTFILE=BANDE_BASSE_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f bb.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
