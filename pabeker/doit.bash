#!/bin/bash
INFILE=`ls PABEKER[^_]* | tail -1 2> /dev/null`
OUTFILE=PABEKER_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f pabeker.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
