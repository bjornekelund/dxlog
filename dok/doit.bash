#!/bin/bash
FILE=`ls WA* | tail -1 2> /dev/null`
OUTFILE=DOK_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f dok.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
