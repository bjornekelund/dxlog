#!/bin/bash
INFILE=`ls NRAUCW* | tail -1 2> /dev/null`
OUTFILE=NRAU_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f nrau.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
