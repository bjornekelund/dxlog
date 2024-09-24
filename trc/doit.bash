#!/bin/bash
FILE=`ls TRCDX* | tail -1 2> /dev/null`
OUTFILE=TRC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f trc.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
