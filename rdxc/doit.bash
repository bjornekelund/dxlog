#!/bin/bash
INFILE=`ls RussianDX-* | tail -1 2> /dev/null`
OUTFILE=RDXC_db.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk -f rdxc.awk $INFILE | sort | sed 's/^\#0. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
../copytosourcetree.bash $OUTFILE

exit
