#!/bin/bash
INFILE=`ls KCJ-* | tail -1 2> /dev/null`
OUTFILE=KCJ_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f kcj.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit

