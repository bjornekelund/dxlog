#!/bin/bash
INFILE=$(ls RCCC* | tail -1 2> /dev/null)
OUTFILE=RCC_db.txt

dos2unix -q $INFILE
echo Parsing $INFILE

gawk -f filter.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
