#!/bin/bash
#INFILE=`ls IG_WW* | tail -1 2> /dev/null`
INFILE=`ls SCRY_* | tail -1 2> /dev/null`
OUTFILE=IG-RY_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f ig-ry.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

exit
