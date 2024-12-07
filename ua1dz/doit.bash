#!/bin/bash
FILE=`ls DZ* | tail -1 2> /dev/null`
OUTFILE=UA1DZ_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f ua1dz.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
