#!/bin/bash
INFILE=`ls QSOP_VT* | tail -1 2> /dev/null`
OUTFILE=VTQP_db.txt
HELPERS=../1helpers/helpers.awk

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f $HELPERS -f vtqp.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
