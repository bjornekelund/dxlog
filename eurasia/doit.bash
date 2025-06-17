#!/bin/bash
INFILE=`ls EUAS-CH* | tail -1 2> /dev/null`
OUTFILE=EURASIA_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f eurasia.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
