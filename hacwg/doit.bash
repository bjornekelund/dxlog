#!/bin/bash
FILE=`ls HA3NS* | tail -1 2> /dev/null`
OUTFILE=HACWG_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f hacwg.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
