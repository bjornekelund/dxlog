#!/bin/bash
INFILE=`ls INDEXAQSOP* | tail -1 2> /dev/null`
OUTFILE=INDEXAQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f indexaqp.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
