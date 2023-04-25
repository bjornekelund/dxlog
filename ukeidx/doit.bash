#!/bin/bash
FILE=`ls UKEIDXC* | tail -1 2> /dev/null`
OUTFILE=UKEIDX_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ukeidx.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
