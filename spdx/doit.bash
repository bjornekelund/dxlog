#!/bin/bash
INFILE=`ls SPDX*[0-9]* | tail -1 2> /dev/null`
OUTFILE=SPDX_db.txt

dos2unix -q $INFILE
echo Parsing $INFILE

gawk -f spdx.awk $INFILE | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
