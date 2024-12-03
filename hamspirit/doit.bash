#!/bin/bash
FILE=`ls HamSpirit* | tail -1 2> /dev/null`
OUTFILE=HAMSPIRIT_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f hamspirit.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit

