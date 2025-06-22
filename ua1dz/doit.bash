#!/bin/bash
INFILE=`ls DZ* | tail -1 2> /dev/null`
OUTFILE=UA1DZ_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f ua1dz.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
