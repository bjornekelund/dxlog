#!/bin/bash
INFILE=`ls QSOP_LA* | tail -1 2> /dev/null`
OUTFILE=LAQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f laqp.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
