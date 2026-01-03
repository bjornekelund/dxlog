#!/bin/bash
INFILE=`ls POTA-* | tail -1 2> /dev/null`
OUTFILE=POTA_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f pota.awk $INFILE | sort | sed 's/#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
