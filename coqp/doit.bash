#!/bin/bash
INFILE=`ls QSOP* | tail -1 2> /dev/null`
OUTFILE=COQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f coqp.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

ls ../copytosourcetree.bash 
. ../copytosourcetree.bash $OUTFILE

exit
