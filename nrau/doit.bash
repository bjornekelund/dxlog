#!/bin/bash
FILE=`ls NRAUCW* | tail -1 2> /dev/null`
OUTFILE=NRAU_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f nrau.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
