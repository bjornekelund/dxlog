#!/bin/bash
INFILE=raw.txt
OUTFILE=RCPW_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f rcpw.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
