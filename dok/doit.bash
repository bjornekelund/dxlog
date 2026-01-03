#!/bin/bash
INFILE=`ls WA* | tail -1 2> /dev/null`
OUTFILE=DOK_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f dok.awk $INFILE | sort | sed 's/#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
