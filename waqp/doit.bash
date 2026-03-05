#!/bin/bash
INFILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=WAQP_db.txt
HELPERS=../1helpers/helpers.awk

echo Parsing $INFILE
dos2unix $INFILE

gawk -f $HELPERS -f waqp.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
