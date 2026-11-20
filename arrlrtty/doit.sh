#!/bin/bash
INFILE=$(ls ARRLR* | tail -1 2> /dev/null)
OUTFILE=ARRL_RTTY_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f arrl-rtty.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
