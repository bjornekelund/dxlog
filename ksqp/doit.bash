#!/bin/bash
FILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=KSQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ksqp.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit
