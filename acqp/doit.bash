#!/bin/bash
INFILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=ACQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f acqp.awk $INFILE | sort | sed 's/#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE $INFILE

../copytosourcetree.bash $OUTFILE

exit
