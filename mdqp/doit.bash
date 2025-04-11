#!/bin/bash
INFILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=MDQP_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f mdqp.awk $INFILE | sort | sed 's/^#./#/g' > MDQP_db.txt

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
