#!/bin/bash
INFILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=NHQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f nhqp.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
