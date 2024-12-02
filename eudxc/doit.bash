#!/bin/bash
FILE=`ls EU_DXC* | tail -1 2> /dev/null`
OUTFILE=EUDXC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f eudxc.awk $FILE > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
