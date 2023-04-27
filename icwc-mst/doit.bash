#!/bin/bash
FILE=`ls ICWC-* | tail -1 2> /dev/null`
OUTFILE=ICWCMST_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f icwc-mst.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
