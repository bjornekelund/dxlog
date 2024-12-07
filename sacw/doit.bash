#!/bin/bash
INFILE=`ls SACW[\.-]* | tail -1 2> /dev/null`
OUTFILE=SACW_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f sacw.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
