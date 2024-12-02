#!/bin/bash
FILE=`ls ARRLVHF[^_]* | tail -1 2> /dev/null`
OUTFILE=ARRL-VHF_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f arrlvhf.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
