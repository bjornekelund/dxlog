#!/bin/bash
FILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=ACQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f acqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
