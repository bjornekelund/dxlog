#!/bin/bash
INFILE=`ls CQWWRTTY* | tail -1 2> /dev/null`
OUTFILE=CQWWR_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f cqww-rtty.awk $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
