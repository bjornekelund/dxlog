#!/bin/bash
FILE=`ls NAVAL.* | tail -1 2> /dev/null`
OUTFILE=NAVAL_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f naval.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE created
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
