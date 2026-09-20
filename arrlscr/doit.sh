#!/bin/bash
INFILE=`ls ARRL-* | tail -1 2> /dev/null`
OUTFILE=ARRL_SCR_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f arrlscr.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
