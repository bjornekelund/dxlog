#!/bin/bash
INFILE=ARRL-SCR-002.txt
OUTFILE=ARRL-SCR-003.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f fix.awk $INFILE | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE
unix2dos -q $INFILE

exit
