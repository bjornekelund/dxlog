#!/bin/bash
FILE=`ls WWFF_t* | tail -1 2> /dev/null`
OUTFILE=WWFF_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f wwff.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
