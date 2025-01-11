#!/bin/bash
# File 2 should be the newer
FILE=`ls CVA.txt | tail -1 2> /dev/null`
OUTFILE=LABREDX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | sed 's/ //g' | gawk -f labredx.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
