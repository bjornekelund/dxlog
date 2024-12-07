#!/bin/bash
FILE=`ls RAEM_[0-9]* | tail -1 2> /dev/null`
OUTFILE=RAEM_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f raem.awk $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

../copytosourcetree.bash $OUTFILE

exit
