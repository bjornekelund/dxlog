#!/bin/bash
FILE=`ls UNDX_[^d]* | tail -1 2> /dev/null`
OUTFILE=UNDX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f undx.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
