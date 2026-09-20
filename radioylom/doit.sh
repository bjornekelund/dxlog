#!/bin/bash
INFILE=`ls RUSYLOM* | tail -1 2> /dev/null`
OUTFILE=RADIOYLOM_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f radioylom.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
