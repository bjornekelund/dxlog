#!/bin/bash
FILE=`ls AGCW-NTC*[0-9].txt | tail -1 2> /dev/null`
OUTFILE=AGCWNTPQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | sed 's/ü/u/g' |  sed 's/é/e/g' | gawk -f agcwntcqp.awk | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
