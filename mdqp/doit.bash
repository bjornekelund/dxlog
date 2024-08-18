#!/bin/bash
FILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=MDQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f mdqp.awk $FILE | sort | sed 's/^#./#/g' > MDQP_db.txt

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
