#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=ONQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f onqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $FILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
