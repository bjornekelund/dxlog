#!/bin/bash
FILE=RCWC.txt
OUTFILE=RCWC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f rcwc.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
