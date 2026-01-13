#!/bin/bash
INFILE=`ls PCC_[MN]* | tail -1 2> /dev/null`
OUTFILE=PCC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f pcc.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
