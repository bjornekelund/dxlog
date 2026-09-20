#!/bin/bash
INFILE=`ls CQWWRTTY* | tail -1 2> /dev/null`
OUTFILE=CQWWR_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f cqww-rtty.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
