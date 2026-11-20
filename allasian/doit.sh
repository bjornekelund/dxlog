#!/bin/bash
INFILE=$(ls ALLASIACW_* | tail -1 2> /dev/null)
OUTFILE=ALLASIAN_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f allasian.awk $INFILE | sort | sed 's/^#0[0-9]/#/g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
