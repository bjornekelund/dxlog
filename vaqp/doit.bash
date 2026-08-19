#!/bin/bash
INFILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=VAQP_db.txt
HELPERS=../1helpers/helpers.awk
echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f $HELPERS -f vaqp.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
