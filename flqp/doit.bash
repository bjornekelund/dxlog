#!/bin/bash
INFILE=`ls QSOP_FL* | tail -1 2> /dev/null`
OUTFILE=FLQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f flqp.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
