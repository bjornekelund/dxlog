#!/bin/bash
INFILE=`ls 1010* | tail -1 2> /dev/null`
OUTFILE=TENTEN_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

sed 's/ //g' $INFILE | gawk -f tenten.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
