#!/bin/bash
INFILE=$(ls TRCDX* | tail -1 2> /dev/null)
OUTFILE=TRC_db.txt
HELPERS=../_helpers/helpers.awk

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f $HELPERS -f trcdx.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit
