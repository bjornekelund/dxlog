#!/bin/bash
INFILE=$(ls CVADXCW*.txt | tail -1 2> /dev/null)
OUTFILE=CVADX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sed 's/ //g' | gawk -f cvadx.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
