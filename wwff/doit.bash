#!/bin/bash
INFILE=`ls WWFF_t* | tail -1 2> /dev/null`
OUTFILE=WWFF_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f wwff.awk $INFILE | sort | sed 's/#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
