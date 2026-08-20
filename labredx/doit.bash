#!/bin/bash
INFILE=`ls LABRE_* | tail -1 2> /dev/null`
OUTFILE=LABREDX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sed 's/ //g' | gawk -f labredx.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
