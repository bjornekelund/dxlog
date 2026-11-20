#!/bin/bash
INFILE=$(ls Helvetia-* | tail -1 2> /dev/null)
OUTFILE=Helvetia_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f helvetia.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
