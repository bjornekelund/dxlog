#!/bin/bash
INFILE=`ls YUDXC* | tail -1 2> /dev/null`
OUTFILE=YUDXC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f yudxc.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
