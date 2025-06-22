#!/bin/bash
INFILE=`ls CVADXCW*.txt | tail -1 2> /dev/null`
OUTFILE=CVADX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

cat $INFILE | sed 's/ //g' | gawk -f cvadx.awk | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
