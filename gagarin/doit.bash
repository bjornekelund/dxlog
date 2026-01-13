#!/bin/bash
INFILE=`ls Gc* | tail -1 2> /dev/null`
OUTFILE=GAGARIN_KUP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f gagarin.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
