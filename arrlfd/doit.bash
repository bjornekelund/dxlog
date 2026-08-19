#!/bin/bash
INFILE=`ls FD* | tail -1 2> /dev/null`
OUTFILE=ARRL_FD_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f arrlfd.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
