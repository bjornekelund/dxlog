#!/bin/bash
FILE=`ls NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=NAQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

sed 's/ //g' $FILE | gawk -f naqp.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
