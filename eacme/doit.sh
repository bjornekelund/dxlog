#!/bin/bash
INFILE=$(ls CME* | tail -1 2> /dev/null)
OUTFILE=EACME_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f eacme.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
