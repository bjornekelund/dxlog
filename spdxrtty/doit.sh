#!/bin/bash
INFILE=SPDXr*
OUTFILE=SPDXRTTY_db.txt

dos2unix -q $INFILE

echo Parsing $INFILE

gawk -f spdx-rtty.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
