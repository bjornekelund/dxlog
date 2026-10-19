#!/bin/bash
INFILE=`ls K1USNSST-* | tail -1 2> /dev/null`
OUTFILE=K1USN_SST_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f k1usn.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
