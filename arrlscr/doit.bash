#!/bin/bash
FILE=`ls ARRL-* | tail -1 2> /dev/null`
OUTFILE=ARRL_SCR_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f arrlscr.awk $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE
unix2dos -q $FILE

../copytosourcetree.bash $OUTFILE

exit
