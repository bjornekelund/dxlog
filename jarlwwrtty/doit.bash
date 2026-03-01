#!/bin/bash
INFILE=`ls JARTSWW* | tail -1 2> /dev/null`
OUTFILE=JARLWWR_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f jarlwwr.awk $INFILE | sort | sed 's/^#0[1-9]/#/g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
