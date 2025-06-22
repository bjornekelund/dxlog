#!/bin/bash
INFILE=`ls BB_* | tail -1 2> /dev/null`
OUTFILE=BANDE_BASSE_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f bb.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
