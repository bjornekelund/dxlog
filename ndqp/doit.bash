#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=NDQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ndqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE $FILE

../copytosourcetree.bash $OUTFILE

exit
