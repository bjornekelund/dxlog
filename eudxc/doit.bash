#!/bin/bash
INFILE=`ls EUDXC-* | tail -1 2> /dev/null`
OUTFILE=EUDXC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f eudxc.awk $INFILE > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
