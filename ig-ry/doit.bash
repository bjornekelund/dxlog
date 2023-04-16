#!/bin/bash

OUTFILE=IG-RY_db.txt
FILE=`ls IG_WW_* | tail -1 2> /dev/null`

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ig-ry.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
