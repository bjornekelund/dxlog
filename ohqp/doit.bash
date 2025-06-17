#!/bin/bash
INFILE=`ls QSOP_OH* | tail -1 2> /dev/null`
OUTFILE=OHQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f ohqp.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
