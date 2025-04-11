#!/bin/bash
INFILE=`ls 13COLONIES-* | tail -1 2> /dev/null`
OUTFILE=13COLONIES_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f 13colonies.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
