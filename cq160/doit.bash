#!/bin/bash
INFILE=`ls CQ160C* | tail -1 2> /dev/null`
OUTFILE=CQ160_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f cq160.awk  $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
