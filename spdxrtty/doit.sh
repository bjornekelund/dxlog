#!/bin/bash
INFILE=SPDXr*
OUTFILE=SPDXRTTY_db.txt

dos2unix -q $INFILE

echo Parsing $INFILE

gawk -f spdx-rtty.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
