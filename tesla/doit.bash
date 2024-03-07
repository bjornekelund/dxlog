#!/bin/bash
FILE=`ls ../stewperry/StewPerry-* | tail -1`
OUTFILE=TESLA_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f tesla.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
