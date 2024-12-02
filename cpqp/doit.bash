#!/bin/bash
FILE=`ls QSOP_CP* | tail -1 2> /dev/null`
OUTFILE=CPQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f cpqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
