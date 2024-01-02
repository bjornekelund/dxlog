#!/bin/bash
FILE=`ls REFCW-*-* | tail -1 2> /dev/null`
OUTFILE=REF_db.txt

echo Parsing $FILE
dos2unix -q $FILE

sed 's/ //g' $FILE | gawk -f ref.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
