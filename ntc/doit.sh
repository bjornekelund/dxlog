#!/bin/bash
INFILE=$(ls NTC_Q* | tail -1 2> /dev/null)
OUTFILE=NTC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

tr -d ' ' < $INFILE | gawk -f ntc.awk | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
