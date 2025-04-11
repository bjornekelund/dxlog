#!/bin/bash
INFILE=RCWC.txt
OUTFILE=RCWC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f rcwc.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
