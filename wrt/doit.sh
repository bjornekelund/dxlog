#!/bin/bash
INFILE=`ls WRT[^_]* | tail -1 2> /dev/null`
OUTFILE=WRT_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f wrt.awk $INFILE | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

cd ../arrlrr; ./doit.sh

exit
