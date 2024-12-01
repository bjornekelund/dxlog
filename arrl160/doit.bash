#!/bin/bash
INFILE=`ls ARRL160* | tail -1 2> /dev/null`
OUTFILE=ARRL_160M_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f arrl160.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
