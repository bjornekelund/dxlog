#!/bin/bash
FILE=`ls INDEXAQSOP* | tail -1 2> /dev/null`
OUTFILE=INDEXAQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f indexaqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
