#!/bin/bash
INFILE=`ls ../rdac/RDAC_2* | tail -1 2> /dev/null`
OUTFILE=UA2_QP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f ua2qp.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
