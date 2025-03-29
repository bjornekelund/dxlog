#!/bin/bash
FILE=`ls K1USNSST-* | tail -1 2> /dev/null`
OUTFILE=K1USN_SST_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f k1usn.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE $FILE

../copytosourcetree.bash $OUTFILE

exit
