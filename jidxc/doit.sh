#!/bin/bash
INFILE=JIDXCW*.txt
OUTFILE=JIDXC_db.txt

echo Parsing $INFILE ...
dos2unix -q $INFILE

gawk -f jidxc.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
