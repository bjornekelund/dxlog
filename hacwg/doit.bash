#!/bin/bash
INFILE=`ls HA3NS* | tail -1 2> /dev/null`
OUTFILE=HACWG_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f hacwg.awk $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE $INFILE

../copytosourcetree.bash $OUTFILE

exit
