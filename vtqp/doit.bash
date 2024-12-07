#!/bin/bash
FILE=`ls QSOP_VT* | tail -1 2> /dev/null`
OUTFILE=VTQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f vtqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
