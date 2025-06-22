#!/bin/bash
INFILE=raw.txt
OUTFILE=RCPW_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f rcpw.awk $INFILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
