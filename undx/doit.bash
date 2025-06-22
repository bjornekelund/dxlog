#!/bin/bash
INFILE=`ls UNDX_[^d]* | tail -1 2> /dev/null`
OUTFILE=UNDX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f undx.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
