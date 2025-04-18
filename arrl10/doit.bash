#!/bin/bash
INFILE=`ls ARRL10M* | tail -1 2> /dev/null`
OUTFILE=ARRL_10M_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f arrl10.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
