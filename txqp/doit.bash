#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=TXQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f txqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
