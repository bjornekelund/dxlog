#!/bin/bash
FILE=`ls JARTSWW* | tail -1 2> /dev/null`
OUTFILE=JARTS_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f jarts.awk $FILE | sort | sed 's/^#[0-9]/#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
