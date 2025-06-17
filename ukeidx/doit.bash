#!/bin/bash
INFILE=`ls UKEIDXC* | tail -1 2> /dev/null`
OUTFILE=UKEIDX_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f ukeidx.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
